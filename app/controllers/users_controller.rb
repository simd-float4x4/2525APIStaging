class UsersController < ApplicationController
  def list
    users = User.includes(:user_meta_names, :user_platforms)

    shuffled_users =  users.shuffle

    users_with_meta = shuffled_users.map do |user|
      {
        userId: user.userId,
        hashtag: '#' + user.hashtag,
        name: user.name,
        metaNames: user.user_meta_names.map(&:userMetaName),
        userPlatforms: user.user_platforms.map do |up|
          if up.hasAccount == true 
            {
              itemId: up.id,
              platformId: up.platformId,
              platformName: up.platformName,
              accountUserId: up.accountUserId,
              accountUserName: up.accountUserName,
              accountIconImageUrl: up.accountIconImageUrl,
              accountUserUrl: up.accountUserUrl,
              accountUserSubText: '@' + up.accountUserSubText,
              hasAccount: up.hasAccount,
              isBroadCasting: up.isBroadCasting
            }
          else 
            {
              itemId: up.itemId,
              hasAccount: false
            }
          end
        end
      }
    end

    pretty_json = JSON.pretty_generate(users_with_meta)
    render plain: pretty_json
  end

  def index
    @users = User.all.page(params[:page])
    render :layout => "layouts/application"
  end

  def show
    @user = User.find_by(userId: params[:id])
    render :layout => "layouts/application"
  end

  def suspend
    @user = User.find_by(userId: params[:userId])
    @item = @user.user_platforms.find_by(id: params[:itemId])
    @item.hasAccount = @item.hasAccount ? false : true
    @item.save
    @user.save
    @users = User.all

    redirect_to user_list_path
  end

  def new
    @user = User.new
    @user.user_meta_names.build
    @user.user_platforms.build
    @platforms = Platform.all
    render :layout => "layouts/application"
  end

  def create
    @user = User.new(user_params)

    user_meta_name = params[:user][:user_meta_names_attributes]
     
    user_meta_name.each do |_, meta_name_param|
      user_meta_name_value = meta_name_param[:userMetaName].split(",")
      user_meta_name_value.each do |split|
        stripped_value = split.gsub("　", "") 
        stripped_value = stripped_value.gsub(" ", "") 
        @user.user_meta_names.build(userMetaName: stripped_value) 
      end
    end

    if @user.save
      redirect_to user_list_path
    else
      @platforms = Platform.all
      render :new, layout: "layouts/application"
    end

    @user.user_meta_names.each do |u|
      logger.debug(u.userMetaName)
    end
  end

  def edit
    @user = User.find(params[:userId])
    @up = UserPlatform.find(params[:itemId])
    @platforms = Platform.all
    render :edit, layout: "layouts/application"
  end
 
  def update
    @user = User.find(params[:userId])
    @up = UserPlatform.find(params[:itemId])

    if @user.update(user_params)
      redirect_to user_list_path
    else
      @platforms = Platform.all
      render :edit, layout: "layouts/application"
    end
  end

  def fetchAPI
    # Twitch API
    @client = Twitch::Client.new(
      client_id: ENV['TWITCH_CLIENT_ID'], 
      access_token: ENV['TWITCH_ACCESS_TOKEN']
    )

    # Twitch
    twitch = UserPlatform.where(platformId: 1)
    twitch.map do |t|
      user_id = t.accountUserId
      if user_id != ''
        data = @client.streams.list(user_id: user_id)
        stream_data = data.data
  
        #データを取得
        if stream_data != []
          t.isBroadCasting = true
          t.save
        else
          t.isBroadCasting = false
          t.save
        end
      end
    end
    redirect_to user_list_path
  end

  def search
    @word = params[:word]
    @users = User.where("name LIKE?", "%#{@word}%")
    render :layout => "layouts/application"
  end

  def hash
    if params[:hashtag]
      @user = User.where(hashtag: params[:hashtag]).first
      if @user
        redirect_to move_user_add_path(userId: @user.userId)
      end
    else
      render :layout => "layouts/application"
    end
  end

  def add
    @this = User.find(params[:userId])
    @up = UserPlatform.where(userId: params[:userId])
    @platforms = Platform.all
    @user_platform = @this.user_platforms.build

    item = UserPlatform.all.order(created_at: :desc).first
    last_item_id = item.itemId + 1
    @lastId = last_item_id

    render :layout => "layouts/application"
  end

  # 新規アカウント追加（予約語に無さそうな絶妙な名前募集中）
  def berry
    
    user_platforms = params[:user][:user_platforms_attributes].to_unsafe_h

    user_platforms.each_with_index do |(key, user_platform_param), i|
      platform_params = ActionController::Parameters.new(user_platform_param).permit(
        :id,
        :platformId, 
        :platformName, 
        :accountUserId, 
        :accountUserName, 
        :accountUserUrl, 
        :accountUserSubText, 
        :accountIconImageUrl, 
        :userId, 
        :itemId, 
        :hasAccount, 
        :isBroadCasting
      )

      if i != user_platforms.size - 1
        @user_platform = UserPlatform.find(platform_params[:id])
        @user_platform.update(platform_params)
      else
        @user_platform = UserPlatform.new(platform_params)
      end
      @user_platform.save
    end

    if @user_platform.save
      redirect_to user_list_path
    else
      logger.debug('errorが起きてて保存できなかった')
      @user_platform
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :hashtag,
      user_meta_names_attributes: [:userMetaName],
      user_platforms_attributes: [
        :id,
        :itemId,
        :accountUserId, 
        :accountUserName, 
        :accountIconImageUrl, 
        :accountUserUrl, 
        :accountUserSubText, 
        :hasAccount, 
        :isBroadCasting, 
        :platformId,
        :platformName
      ]
    )
  end

  def user_platform_params
    params.require(:user_platform).permit(
      :id,
      :userId, 
      :itemId, 
      :platformId, 
      :platformName, 
      :accountUserId, 
      :accountUserName, 
      :accountIconImageUrl, 
      :accountUserUrl, 
      :accountUserSubText, 
      :hasAccount, 
      :isBroadCasting
    )
  end

  def current_donuts
    if session[:donut_id]
      @donut = Donut.find(session[:donut_id])
    else
      flash[:alert] = "ログインする必要があります。"
      redirect_to new_sessions_path
    end
  end
end