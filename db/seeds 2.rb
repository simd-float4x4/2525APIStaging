# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Platform.create(
  platformId: 1, 
  platformName: 'Twitch', 
  icon:'fa-brands fa-twitch', 
  imageURL: '', 
  brandColor:'#6441a5',
  titleNotice: 'Twitchをご利用中のみなさん',
  titleSentence: '※ 5分に1回程度配信状況を自動的に更新します（多少の誤差はあります）')

Platform.create(
  platformId: 2, 
  platformName: 'ふわっち', 
  icon:'', 
  imageURL: '', 
  brandColor:'#fb5824',
  titleNotice: 'ふわっちをご利用中のみなさん',
  titleSentence: '※ 2024年7月6日現在、リアルタイム配信はTwitchのみ取得して表示しております。
  このプラットフォームにつきましては、今後のリリースをお待ちください。')

Platform.create(
  platformId: 3, 
  platformName: 'ツイキャス', 
  icon:'', 
  imageURL: '', 
  brandColor:'#0273ff',
  titleNotice: 'ツイキャスをご利用中のみなさん',
  titleSentence: '※ 2024年7月6日現在、リアルタイム配信はTwitchのみ取得して表示しております。
  このプラットフォームにつきましては、今後のリリースをお待ちください。')

Platform.create(
  platformId: 4, 
  platformName: 'YouTubeLive', 
  icon:'fa-brands fa-youtube', 
  imageURL: '', 
  brandColor:'#C4302B',
  titleNotice: 'YouTubeLiveをご利用中のみなさん',
  titleSentence: '※ 2024年7月6日現在、リアルタイム配信はTwitchのみ取得して表示しております。
  このプラットフォームにつきましては、今後のリリースをお待ちください。')

Platform.create(
  platformId: 5, 
  platformName: 'オープンチャット', 
  icon:'fa-brands fa-line', 
  imageURL: '', 
  brandColor:'#06c755',
  titleNotice: 'オープンチャットをご利用中のみなさん',
  titleSentence: '※ ご本人が運営もしくは公認のLINEオープンチャットのみ集計対象とさせていただいております。（非公式オープンチャットは対象外）
  公式アカウントにつきましては、今後のリリースをお待ちください。')

Platform.create(
  platformId: 6, 
  platformName: 'X', 
  icon:'fa-brands fa-square-x-twitter', 
  imageURL: '', 
  brandColor:'#0f1419',
  titleNotice: 'Xをご利用中のみなさん',
  titleSentence: '')

Platform.create(
  platformId: 7, 
  platformName: 'Instagram', 
  icon:'fa-brands fa-instagram', 
  imageURL: '',
  brandColor:'#cf2e92',
  titleNotice: 'Instagramをご利用中のみなさん',
  titleSentence: '')

Platform.create(
  platformId: 8, 
  platformName: 'TikTok', 
  icon:'fa-brands fa-tiktok', 
  imageURL: '', 
  brandColor:'#fe2c55',
  titleNotice: 'TikTokをご利用中のみなさん',
  titleSentence: '')

Platform.create(
  platformId: 9, 
  platformName: 'OpenRec', 
  icon:'', 
  imageURL: '', 
  brandColor:'#ff4c11',
  titleNotice: 'OpenRecをご利用中のみなさん',
  titleSentence: '')

Platform.create(
  platformId: 997, 
  platformName: 'ALL', 
  icon:'', 
  imageURL: '', 
  brandColor:'#BAA898',
  titleNotice: '全ユーザーからランダムで表示します',
  titleSentence: '')

Platform.create(
  platformId: 998, 
  platformName: '配信中', 
  icon:'fa-solid fa-video', 
  imageURL: '', 
  brandColor:'red',
  titleNotice: '配信中の全アカウントからランダムで表示します',
  titleSentence: '※ 2024年7月6日現在、リアルタイム配信はTwitchのみ取得して表示しております。')

Platform.create(
  platformId: 999, 
  platformName: 'その他', 
  icon:'fa-solid fa-ellipsis-vertical', 
  imageURL: '', 
  brandColor:'#6f4b3e',
  titleNotice: 'その他プラットフォームをご利用中のみなさん',
  titleSentence: '')

User.create(userId: 1, hashtag: '5105', name: 'かつき（ににまる）')
User.create(userId: 2, hashtag: '4965', name: 'ウェイパー高橋')
User.create(userId: 3, hashtag: '8568', name: 'しんせいねう')
User.create(userId: 4, hashtag: '3820', name: 'おっちち姫')
User.create(userId: 5, hashtag: '8464', name: 'たっちゃん')
User.create(userId: 6, hashtag: '7090', name: 'イノシシ')
User.create(userId: 7, hashtag: '3362', name: 'かしゅ')
User.create(userId: 8, hashtag: '8571', name: 'かなた')
User.create(userId: 9, hashtag: '3427', name: '無限')
User.create(userId: 10, hashtag: '9173', name: 'カマキリ')
User.create(userId: 11, hashtag: '3636', name: 'ずいえき')
User.create(userId: 12, hashtag: '4902', name: 'カクコ')
User.create(userId: 13, hashtag: '1984', name: 'お蛸')
User.create(userId: 14, hashtag: '9409', name: 'とろみ')
User.create(userId: 15, hashtag: '1977', name: 'ぽわりぽあち')
User.create(userId: 16, hashtag: '8122', name: 'もっちゃん')

# ユーザープラットフォームの追加
UserPlatform.create(
  userId: 1,
  itemId: 1,
  platformId: 1,
  platformName: 'Twitch',
  accountUserSubText: '220ninimaru',
  accountUserId: '1061197608',
  accountUserName: '岩崎かつき',
  accountIconImageUrl: 'https://static-cdn.jtvnw.net/jtv_user_pictures/bf505f86-40f1-40aa-bb88-40a9389a612c-profile_image-70x70.png',
  accountUserUrl: 'https://www.twitch.tv/220ninimaru',
  hasAccount: true,
  isBroadCasting: false,
)

UserPlatform.create(
  userId: 1,
  itemId: 2,
  platformId: 6,
  platformName: 'X',
  accountUserSubText: '220niconico',
  accountUserId: '',
  accountUserName: '岩崎かつき',
  accountIconImageUrl: 'https://static-cdn.jtvnw.net/jtv_user_pictures/bf505f86-40f1-40aa-bb88-40a9389a612c-profile_image-70x70.png',
  accountUserUrl: 'https://twitter.com/220niconico',
  hasAccount: true,
  isBroadCasting: false,
)

# ユーザーメタネームの追加
UserMetaName.create(userId: 1, userMetaName: 'かつき')
UserMetaName.create(userId: 1, userMetaName: 'ににまる')
UserMetaName.create(userId: 1, userMetaName: 'まんちょ')
UserMetaName.create(userId: 1, userMetaName: '岩崎かつき')


# # ユーザーメタネームの追加
UserMetaName.create(userId: 2, userMetaName: 'ウェイパー')
UserMetaName.create(userId: 2, userMetaName: '高橋')

UserPlatform.create(
  userId: 2,
  itemId: 3,
  platformId: 1,
  platformName: 'Twitch',
  accountUserSubText: 'takahashi0426',
  accountUserId: '749947360',
  accountUserName: 'ウェイパー高橋',
  accountIconImageUrl: 'https://static-cdn.jtvnw.net/jtv_user_pictures/b6f09453-f56b-47fa-a0c6-b9d690f48c5c-profile_image-70x70.png',
  accountUserUrl: 'https://m.twitch.tv/takahashi0426',
  hasAccount: true,
  isBroadCasting: false,
)

UserPlatform.create(
  userId: 2,
  itemId: 4,
  platformId: 6,
  platformName: 'X',
  accountUserSubText: 'tkhs042',
  accountUserId: '',
  accountUserName: 'ウェイパー高橋',
  accountIconImageUrl: 'https://pbs.twimg.com/profile_images/1245641376127021057/Jmk1n94w_400x400.jpg',
  accountUserUrl: 'https://twitter.com/tkhs0426',
  hasAccount: true,
  isBroadCasting: false,
)
# 1 Twitch 2 ツイキャス　3 ふわっち　6 X



# # ユーザーメタネームの追加
UserMetaName.create(userId: 3, userMetaName: 'しんせいねう')
UserMetaName.create(userId: 3, userMetaName: 'ねう')

UserPlatform.create(
  userId: 3,
  itemId: 5,
  platformId: 7,
  platformName: 'TikTok',
  accountUserSubText: 'sinseinaru',
  accountUserId: '',
  accountUserName: 'しんせいねう',
  accountIconImageUrl: 'https://pbs.twimg.com/profile_images/1722922807666061312/n6erokfP_400x400.jpg',
  accountUserUrl: 'https://twitter.com/sinseinaru',
  hasAccount: true,
  isBroadCasting: false,
)
# 1 Twitch 2 ツイキャス　3 ふわっち　6 X


UserPlatform.create(
  userId: 3,
  itemId: 6,
  platformId: 2,
  platformName: 'ツイキャス',
  accountUserSubText: 'c:fukai_ao',
  accountUserId: '',
  accountUserName: 'しんせいねう',
  accountIconImageUrl: 'https://imagegw02.twitcasting.tv/image3s/img-twitcasting.s3-us-west-1.amazonaws.com/07/7c/642ed9d445fdf_64.jpg',
  accountUserUrl: 'https://twitcasting.tv/c:fukai_ao',
  hasAccount: true,
  isBroadCasting: false,
)
# 1 Twitch 2 ツイキャス　3 ふわっち　6 X




# # ユーザーメタネームの追加
UserMetaName.create(userId: 4, userMetaName: 'モアちゃん')
UserMetaName.create(userId: 4, userMetaName: 'まきちゃん')
UserMetaName.create(userId: 4, userMetaName: '🗿')
UserMetaName.create(userId: 4, userMetaName: 'おっちち')
UserMetaName.create(userId: 4, userMetaName: '姫')


UserPlatform.create(
  userId: 4,
  itemId: 7,
  platformId: 2,
  platformName: 'ツイキャス',
  accountUserSubText: 'akirametai_hime',
  accountUserId: '',
  accountUserName: 'おっちち姫',
  accountIconImageUrl: 'https://imagegw02.twitcasting.tv/image3s/pbs.twimg.com/profile_images/1745297484119977984/agOpao8A_bigger.jpg',
  accountUserUrl: 'https://twitcasting.tv/akirametai_hime/',
  hasAccount: true,
  isBroadCasting: false,
)
# 1 Twitch 2 ツイキャス　3 ふわっち　6 X

UserPlatform.create(
  userId: 4,
  itemId: 8,
  platformId: 8,
  platformName: 'Instagram',
  accountUserSubText: 'akirametai_hime',
  accountUserId: '',
  accountUserName: 'おっちち姫',
  accountIconImageUrl: 'https://pbs.twimg.com/profile_images/1745297484119977984/agOpao8A_400x400.jpg',
  accountUserUrl: 'https://twitter.com/akirametai_hime',
  hasAccount: true,
  isBroadCasting: false,
)
# 1 Twitch 2 ツイキャス　3 ふわっち　6 X



# # ユーザーメタネームの追加
UserMetaName.create(userId: 5, userMetaName: 'おじ雑')
UserMetaName.create(userId: 5, userMetaName: 'たっちゃん')

# # ユーザープラットフォームの追加
# user5.user_platforms.create(
#   platform: twitcasting,
#   has_account: true,
#   is_broadcasting: false,
#   display_text_content: 'tatsuya0519',
#   account_user_name: 'たっちゃん',
#   account_url: 'https://whowatch.tv/profile/w:tatsuya0519',
#   account_icon_image_url: 'https://img.whowatch.tv/user_files/56822518/profile_icon/1718556678257.jpeg'
# )


UserPlatform.create(
  userId: 5,
  itemId: 9,
  platformId: 3,
  platformName: 'ふわっち',
  accountUserSubText: 'tatsuya0519',
  accountUserId: '',
  accountUserName: 'たっちゃん',
  accountIconImageUrl: 'https://img.whowatch.tv/user_files/56822518/profile_icon/1718556678257.jpeg',
  accountUserUrl: 'https://whowatch.tv/profile/w:tatsuya0519',
  hasAccount: true,
  isBroadCasting: false,
)
# 1 Twitch 2 ツイキャス　3 ふわっち　6 X



# # ユーザーメタネームの追加
UserMetaName.create(userId: 6, userMetaName: 'イノシシ')
UserMetaName.create(userId: 6, userMetaName: 'のうや')
UserMetaName.create(userId: 6, userMetaName: '腐れパープル歯茎')
UserMetaName.create(userId: 6, userMetaName: 'キンタマ')
UserMetaName.create(userId: 6, userMetaName: '金玉')


UserPlatform.create(
  userId: 6,
  itemId: 10,
  platformId: 3,
  platformName: 'ふわっち',
  accountUserSubText: 'inosisi2525',
  accountUserId: '',
  accountUserName: 'イノシシ',
  accountIconImageUrl: 'https://img.whowatch.tv/user_files/22272815/profile_icon/1646029166618.jpeg',
  accountUserUrl: 'https://whowatch.tv/profile/t:inosisi2525',
  hasAccount: true,
  isBroadCasting: false,
)
# 1 Twitch 2 ツイキャス　3 ふわっち　6 X



# # ユーザーメタネームの追加
UserMetaName.create(userId: 7, userMetaName: 'かしゅちゃん')
UserMetaName.create(userId: 7, userMetaName: 'かしゅ')

UserPlatform.create(
  userId: 7,
  itemId: 11,
  platformId: 2,
  platformName: 'ツイキャス',
  accountUserSubText: 'kashu_v0916',
  accountUserId: '',
  accountUserName: 'かしゅちゃん',
  accountIconImageUrl: 'https://imagegw02.twitcasting.tv/image3s/pbs.twimg.com/profile_images/1790800649426538496/FNlq_i-O_bigger.jpg',
  accountUserUrl: 'https://twitcasting.tv/kashu_v0916/',
  hasAccount: true,
  isBroadCasting: false,
)
# 1 Twitch 2 ツイキャス　3 ふわっち　6 X

UserPlatform.create(
  userId: 7,
  itemId: 12,
  platformId: 5,
  platformName: 'オープンチャット',
  accountUserId: '',
  accountUserSubText: 'kashu_v0916',
  accountUserName: 'かしゅちゃん',
  accountIconImageUrl: 'https://pbs.twimg.com/profile_images/1790800649426538496/FNlq_i-O_400x400.jpg',
  accountUserUrl: 'https://twitter.com/kashu_v0916',
  hasAccount: true,
  isBroadCasting: false,
)

UserPlatform.create(
  userId: 8,
  itemId: 13,
  platformId: 1,
  platformName: 'Twitch',
  accountUserId: '597331064',
  accountUserSubText: 'kanatan_2525',
  accountUserName: 'かなた',
  accountIconImageUrl: 'https://static-cdn.jtvnw.net/jtv_user_pictures/e8e65c80-f5b2-47a8-9435-498c204e0ff6-profile_image-70x70.png',
  accountUserUrl: 'https://www.twitch.tv/kanatan_2525',
  hasAccount: true,
  isBroadCasting: false,
)

UserPlatform.create(
  userId: 9,
  itemId: 14,
  platformId: 1,
  platformName: 'Twitch',
  accountUserId: '734475412',
  accountUserSubText: 'infinity_mkds',
  accountUserName: '無限',
  accountIconImageUrl: 'https://static-cdn.jtvnw.net/jtv_user_pictures/b4ecf22e-5c94-4de5-a64b-4b223fba887c-profile_image-70x70.png',
  accountUserUrl: 'https://www.twitch.tv/infinity_mkds',
  hasAccount: true,
  isBroadCasting: false,
)

UserPlatform.create(
  userId: 10,
  itemId: 15,
  platformId: 1,
  platformName: 'Twitch',
  accountUserSubText: 'kamakiri2525',
  accountUserId: '930979913',
  accountUserName: 'kamakiri2525',
  accountIconImageUrl: 'https://static-cdn.jtvnw.net/jtv_user_pictures/38ac5dee-50fc-4d6a-a858-bedf48a5cadc-profile_image-70x70.png',
  accountUserUrl: 'https://www.twitch.tv/kamakiri2525',
  hasAccount: true,
  isBroadCasting: false,
)

UserPlatform.create(
  userId: 11,
  itemId: 16,
  platformId: 1,
  platformName: 'Twitch',
  accountUserSubText: 'zuieki_tv123',
  accountUserId: '712905765',
  accountUserName: 'zuieki_tv123',
  accountIconImageUrl: 'https://static-cdn.jtvnw.net/jtv_user_pictures/0637991f-520c-4cef-a5a2-2db666fab282-profile_image-70x70.png',
  accountUserUrl: 'https://www.twitch.tv/zuieki_tv123',
  hasAccount: true,
  isBroadCasting: false,
)
UserPlatform.create(
  userId: 14,
  itemId: 17,
  platformId: 1,
  platformName: 'Twitch',
  accountUserSubText: 'toromi2525',
  accountUserId: '807439015',
  accountUserName: 'とろみ_',
  accountIconImageUrl: 'https://static-cdn.jtvnw.net/jtv_user_pictures/25b47234-cbfa-4ad6-8434-7f1291a8b7b0-profile_image-70x70.png',
  accountUserUrl: 'https://www.twitch.tv/toromi2525',
  hasAccount: true,
  isBroadCasting: false,
)

UserPlatform.create(
  userId: 13,
  itemId: 18,
  platformId: 1,
  platformName: 'Twitch',
  accountUserSubText: 'otakodeath55',
  accountUserId: '675062582',
  accountUserName: 'お蛸',
  accountIconImageUrl: 'https://static-cdn.jtvnw.net/jtv_user_pictures/0d0e408d-1662-42ae-8f23-751c4dcd97c5-profile_image-70x70.png',
  accountUserUrl: 'https://www.twitch.tv/otakodeath55',
  hasAccount: true,
  isBroadCasting: false,
)

UserPlatform.create(
  userId: 12,
  itemId: 19,
  platformId: 1,
  platformName: 'Twitch',
  accountUserSubText: 'kakuko_deluxe',
  accountUserId: '490886905',
  accountUserName: 'カクコ',
  accountIconImageUrl: 'https://static-cdn.jtvnw.net/jtv_user_pictures/f5a0ae00-0a36-461d-b069-d0beee6ce7a6-profile_image-70x70.png',
  accountUserUrl: 'https://www.twitch.tv/kakuko_deluxe',
  hasAccount: true,
  isBroadCasting: false,
)

UserPlatform.create(
  userId: 15,
  itemId: 20,
  platformId: 1,
  platformName: 'Twitch',
  accountUserSubText: 'poachi_',
  accountUserId: '987942730',
  accountUserName: 'ぽわりぽあち',
  accountIconImageUrl: 'https://static-cdn.jtvnw.net/jtv_user_pictures/78449ffc-8709-4b2a-b0fd-0c837dab6c29-profile_image-70x70.png',
  accountUserUrl: 'https://www.twitch.tv/poachi_',
  hasAccount: true,
  isBroadCasting: false,
)

UserPlatform.create(
  userId: 16,
  itemId: 21,
  platformId: 1,
  platformName: 'Twitch',
  accountUserSubText: 'moshushidayo',
  accountUserId: '577375340',
  accountUserName: 'もっちゃんこともしゅし',
  accountIconImageUrl: 'https://static-cdn.jtvnw.net/jtv_user_pictures/7cc1b499-1bc4-4fa8-85d6-344e05ad26b9-profile_image-70x70.png',
  accountUserUrl: 'https://www.twitch.tv/moshushidayo',
  hasAccount: true,
  isBroadCasting: false,
)

Donut.create(
  id: 1,
  name: 'root',
  tokenA: 'a',
  tokenB: 'a',
  tokenC: 'a',
  tokenD: '123456',
)