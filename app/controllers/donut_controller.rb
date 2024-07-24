class DonutController < ApplicationController
    require 'httparty'
    require 'json'
    require 'net/http'
    require 'uri'

    skip_before_action :require_donut_session, only: [:index, :create, :user_list, :banner_list, :notice_list, :notice_first, :platform_list, :version_list, :fetchAPI]
    before_action :logged_in?, only: [:index, :create, :user_list, :banner_list, :notice_list, :notice_first, :platform_list, :version_list, :fetchAPI]
    # before_action :set_request_variant

    def index
        render layout: "layouts/application"
    end

    def second
        render layout: "layouts/application"
    end

    def create
        @donut = Donut.find_by(tokenA: params[:tokenA], tokenB: params[:tokenB], tokenC: params[:tokenC])
        @history = History.new

        if @donut
            session[:donut_id] = @donut.id
            
            @history.ipAddress = request.remote_ip
            @history.os = request.os 
            @history.device = request.device_type
            @history.browser = request.browser 
            @history.user_agent = request.user_agent

            if @history.save
                logger.debug('成功')
                redirect_to user_list_path
            elsif
                render :index, layout: "layouts/application"
            end
        else
            logger.debug('失敗')
            logger.debug(params[:tokenA])
            logger.debug(params[:tokenB])
            logger.debug(params[:tokenC])
            
            render :index, layout: "layouts/application"
        end
    end

    def destroy
        session[:donut_id] = nil
        redirect_to login_sessions_path
    end

    def user_list
        users = User.includes(:user_meta_names, :user_platforms)
    
        shuffled_users =  users.shuffle
        prefix = '@'
    
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
                  if platformId === 3 || platformId === 999
                  accountUserSubText: up.accountUserSubText,
                  elsif
                  accountUserSubText: prefix + up.accountUserSubText,
                  end
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

    def banner_list
      banners = Banner.all.order(imageSortNumber: "DESC").where(hasPublished: true)

      banner_data = banners.map do |banner|
        {
          bannerCount: banners.length,
          bannerIsPublished: banner.hasPublished,
          bannerURL: banner.imageURL,
          bannerSortId: banner.imageSortNumber,
          bannerTransitionURL: banner.transitionURL
        }
      end

      pretty_json = JSON.pretty_generate(banner_data)
      render plain: pretty_json
    end

    def notice_list
      notices = Notice.all.order(created_at: "DESC").where(hasPublished: true)

      notice_data = notices.map do |notice|
        {
          id: notice.id,
          noticeTitle: notice.title,
          noticeDate: notice.date,
          noticeCategory: notice.mainCategory,
          noticeBody: notice.body
        }
      end
    
      pretty_json = JSON.pretty_generate(notice_data)
      render plain: pretty_json
    end

    def notice_first
      notice = Notice.all.order(created_at: "DESC").where(hasPublished: true).first

      notice_data = 
        {
          id: notice.id,
          noticeTitle: notice.title,
          noticeDate: notice.date,
          noticeCategory: notice.mainCategory,
          noticeBody: notice.body
        }
    
      pretty_json = JSON.pretty_generate(notice_data)
      render plain: pretty_json
    end


  def platform_list
    platforms = Platform.all

    platform_data = platforms.map do |platform|
      {
        platformId: platform.platformId,
        platformName: platform.platformName,
        platformIcon: platform.icon,
        platformImageURL: platform.imageURL,
        platformBrandColor: platform.brandColor,
        platformTitleSentence: platform.titleNotice,
        platformTitleNotice: platform.titleSentence,
      }
    end

    pretty_json = JSON.pretty_generate(platform_data)
    render plain: pretty_json
  end

  def version_list
    version = Version.first
    terms = Term.first
    privacy = Privacy.first

    if version && terms && privacy 
      version_data = 
      {
        currentVersion: version.version,
        currentTerms: terms.content,
        currentPrivacy: privacy.content
      }
    elsif
      version_data = {
        
      }
    end

    pretty_json = JSON.pretty_generate(version_data)
    render plain: pretty_json
  end

  def fetchAPI

    self.whowatch

    # Twitch API
    @client = Twitch::Client.new(
      client_id: ENV['TWITCH_CLIENT_ID'], 
      access_token: ENV['TWITCH_ACCESS_TOKEN']
    )

    webhook_url = ENV['SLACK_WEBHOOK_URL']

    if @client == nil 
      payload = { text: ENV['SLACK_NOTIFICATION_BODY'] }.to_json
      HTTParty.post(webhook_url, body: payload, headers: { 'Content-Type' => 'application/json' })
    else
      current_time = Time.zone.now
      payload = { text: "#{current_time.strftime("%H:%M:%S　")}" + "（Twitch）データの取得を開始します" }.to_json
      HTTParty.post(webhook_url, body: payload, headers: { 'Content-Type' => 'application/json' })
    end

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
          t.accountUserName = stream_data[0].user_name
          
          if @client.users.retrieve(id: user_id)
            t.accountIconImageUrl = @client.users.retrieve(id: user_id).profile_image_url
          end

          payload = { text: "・" + t.accountUserName + "さんが配信しています" }.to_json
          HTTParty.post(webhook_url, body: payload, headers: { 'Content-Type' => 'application/json' })

          payload = { text: stream_data[0] }.to_json
          HTTParty.post(webhook_url, body: payload, headers: { 'Content-Type' => 'application/json' })
          t.save
        else
          t.isBroadCasting = false
          t.save
        end
      end
    end
    redirect_to request.referer
  end

  def whowatch
    uri = URI.parse('https://api.whowatch.tv/lives')
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    # 返ってくる値にデータがあるなら配信中という認識でOK
    
    whowatch = UserPlatform.where(platformId: 3)

    data.each do |category|
      category_id = category['category_id']
      puts "User Name: #{category_id}"
      category['new'].each do |newdata|
        new_id = newdata['id']
        puts "New id: #{new_id}"
        user = newdata['user']
        puts "User: #{user}"
        user_id = user['id']
        user_name = user['name']
        puts "User Name: #{user_name}"
        user_icon_url = user['icon_url']
        user_path = user['user_path']
        w = whowatch.where(accountUserId: user['id'])
        puts "User ID: #{user['id']}"
        w.isBroadCasting = true
        w.accountUserName = user['name']
        w.accountUserSubText = user['user_path']
        w.accountUserUrl = 'https://whowatch.tv/viewer/' + new_id
        w.accountIconImageUrl = user['icon_url']
        w.save
      end
    end
  end

  private
  # def set_request_variant
  #     request.variant = request.device_type # :pc, :smartphone, etc
  # end

  def logged_in?
      if session[:donut_id]
          @donut = Donut.find(session[:donut_id])
          redirect_to user_list_path
      end
  end
end