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
                  accountUserSubText: (up.platformId == 3 || up.platformId == 999) ? up.accountUserSubText : prefix + up.accountUserSubText,
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
    self.startFetchNotice
    self.twitch
    self.whowatch
    self.twitcasting
    redirect_to request.referer
  end

  def startFetchNotice
    webhook_url = ENV['SLACK_WEBHOOK_URL']
    current_time = Time.zone.now
    payload = { text: "#{current_time.strftime("%H:%M:%S　")}" + "データの取得を開始します" }.to_json
    HTTParty.post(webhook_url, body: payload, headers: { 'Content-Type' => 'application/json' })
  end

  def twitcasting
    webhook_url = ENV['SLACK_WEBHOOK_URL']
    payload = { text: "【ツイキャス】====" }.to_json
    HTTParty.post(webhook_url, body: payload, headers: { 'Content-Type' => 'application/json' })

    twc_uids = []
    twc_ups = UserPlatform.where(platformId: 2)

    twc_ups.each do | tw |
      twc_uids << tw.accountUserSubText
    end

    puts "🍨 222 ユーザーID: #{twc_uids}"
    
    twc_uids.each do | thisUser |
      # 完全なURLを作成
      host = "https://apiv2.twitcasting.tv/users/"
      prefix = "/current_live"
      url = URI.join(host, thisUser, prefix).to_s
      puts "🥮 218 url.class: #{url.class}"

      response = HTTParty.get(
        url,
        headers: {
          "Accept" => "application/json",
          "X-Api-Version" => "2.0",
          "Authorization" => "#{ENV['TWITCASTING_TOKEN']}"
        }
      )

      puts "🥮 226 url: #{url}"
      puts "#{ENV['TWITCASTING_TOKEN']}"

      puts "🌮 233 ユーザーID: #{thisUser}"
      puts "🍌 234 response: #{response}"
      puts "🍌 234 response: #{response.success?}"

      if response
        data = response
      
        if data
          puts "👀　225：データの取得を開始しました(ツイキャス)"
          data.each do | user |
            next if user.nil?
            user_url = user['movie'].link

            user['broadcaster'].each do |info|
              user_id = info['id']
              result = twc_ups.find { |id| id == user_id }

              if result
                twc = UserPlatform.where(platformId: 2).find_by(accountUserId: user_id)
                puts "🍰 234 User Found!（ツイキャス）: #{user_id}, #{info['name']}"

                twc.isBroadCasting = info['is_live']
                twc.accountUserName = info['name']
                twc.accountUserSubText = info['screen_id']
                twc.accountUserUrl = user_url
                twc.accountIconImageUrl = info['image']
                twc.save
    
                payload = { text: "・" + twc.accountUserName + "さんが配信しています" }.to_json
                HTTParty.post(webhook_url, body: payload, headers: { 'Content-Type' => 'application/json' })
              end
            end
          end
          puts "👀　246：ツイキャスのスキャニングが完了しました"
        else
          puts "🚨 Whowatch Error: Failed to Fetch Data"
        end

      else
        puts "🚨 Twitcasting Error: Failed to Fetch Data"
        payload = { text: "<!channel> Error: #{response.code} - #{response.message}" }.to_json
        HTTParty.post(webhook_url, body: payload, headers: { 'Content-Type' => 'application/json' })
      end
    end
  end

  def whowatch
    webhook_url = ENV['SLACK_WEBHOOK_URL']
    payload = { text: "【ふわっち】===="}.to_json
    HTTParty.post(webhook_url, body: payload, headers: { 'Content-Type' => 'application/json' })

    uri = URI.parse('https://api.whowatch.tv/lives')
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)

    w_uids = []
    w_ups = UserPlatform.where(platformId: 3)

    w_ups.each do | wu |
      w_uids << wu.accountUserId
    end

    puts "🍔 248 ユーザーIDs: #{w_uids}"

    if data
      puts "👀　242：データの取得を開始しました(whowatch)"
      data.each do |category|
        next if category.nil?
        category['popular'].each do |live|
          user_id = live['user']['id']
          result = w_ups.find { |id| id == user_id }
          if result
            w = UserPlatform.where(platformId: 3).find_by(accountUserId: user_id)
            puts "🍩 272 User Found!（whowatch）: #{user_id}, #{live['user']['name']}"
            w.isBroadCasting = true
            w.accountUserName = live['user']['name']
            w.accountUserSubText = live['user']['user_path']
            w.accountUserUrl = 'https://whowatch.tv/viewer/' + live['id'].to_s
            w.accountIconImageUrl = live['user']['icon_url']
            w.save

            payload = { text: "・" + w.accountUserName + "さんが配信しています" }.to_json
            HTTParty.post(webhook_url, body: payload, headers: { 'Content-Type' => 'application/json' })
          end
        end
      end
      puts "👀　258：ふわっちのスキャニングが完了しました"
    else
      puts "🚨 Whowatch Error: Failed to Fetch Data"
    end
  end

  def twitch
    puts "👀　310：データの取得を開始しました(twitch)"
    webhook_url = ENV['SLACK_WEBHOOK_URL']

    payload = { text: "【Twitch】===="}.to_json
    HTTParty.post(webhook_url, body: payload, headers: { 'Content-Type' => 'application/json' })

    @client = Twitch::Client.new(
      client_id: ENV['TWITCH_CLIENT_ID'], 
      access_token: ENV['TWITCH_ACCESS_TOKEN']
    )

    if @client == nil 
      payload = { text: ENV['SLACK_NOTIFICATION_BODY'] }.to_json
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
    puts "👀　355：twitchのスキャニングが完了しました"
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