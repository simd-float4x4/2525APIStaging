namespace :fetch_api do
    desc "TwitchAPIを定期的に取得する"
    task twitch: :environment do
        puts "Hello, Twitch API was activated!"
        puts "==="
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
                    puts t.accountUserName
                    puts "true"
                    t.save
                else
                    t.isBroadCasting = false
                    puts t.accountUserName
                    puts "false"
                    t.save
                end
            end
        end
        puts "==="
        current_time = Time.zone.now
        puts "#{current_time.strftime("%Y年 %m月%d日 %H:%M:%S")}"
    end
end