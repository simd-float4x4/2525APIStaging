Rails.application.routes.draw do
  get 'privacy/new'
  get 'privacy/create'
  get 'term/new'
  get 'term/create'
  get 'version/index'
  get 'version/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :banners


# ========
#　ドーナツ
# ========

# トークン認証（ルート）
  root to: 'donut#index', as: 'login_sessions'

# トークン認証（POST）
  post '/redirecting', to: 'donut#create', as: 'first_login_sessions'

# 二段階認証
  get '/2FA', to: 'donut#second', as: 'new_sessions'

# ログアウト
  get '/logout', to: 'donut#destroy', as: 'destroy_sessions'
  delete '/logout', to: 'donut#destroy'

# SMS認証

# ========
#　ドーナツAPI
# ========

user_path = ENV['USER_PATH']
banner_path = ENV['BANNER_PATH']
notice_path = ENV['NOTICE_PATH']
notice_first_path = ENV['NOTICE_FIRST_PATH']
platform_path = ENV['PLATFORM_PATH']
version_path = ENV['VERSION_PATH']
twitch_api_path = ENV['TWITCH_API_PATH']

#　ユーザー
  get "/v1/#{user_path}/donut/index", to: "donut#user_list"

#　プラットフォーム
  get "/v1/#{platform_path}/platform/list", to: 'donut#platform_list'

# お知らせ
  get "/v1/#{notice_path}/notice/list", to: 'donut#notice_list'

# お知らせ（最初の一件）
  get "/v1/#{notice_first_path}/notice/list/1st", to: "donut#notice_first"

# バナー
  get "/v1/#{banner_path}/banner/list", to: 'donut#banner_list'

# バージョン
  get "/v1/#{version_path}/version/list", to: 'donut#version_list'

# TwitchAPI更新
  get "/v1/#{twitch_api_path}/fetch/API", to: "donut#fetchAPI"

# ========
#　ユーザー
# ========

# 一覧
  get '/v1/0x2d0r31/user/index', to: "users#index", as: 'user_list'

# 新規
  get "/v1/xy76Za109b/user/create", to: "users#new", as: 'move_user_create'
  post "/v1/xy76Za109b/user/create", to: "users#create", as: 'post_user_create'

# ハッシュタグ
  get "/v1/uKu3Hdwj7i/user/hash_tag", to: "users#hash", as: 'user_hashtag_search'
  # post "/SF6Jbs0O1y/v1/user/searching", to: "users#hash", as: 'user_sending'

# ユーザにUserPlatFormを追加
  get "/v1/MqahkHTHbC/user/add", to: "users#add", as: 'move_user_add'
  post "/v1/YqFlFOKvVu/user/insert", to: "users#berry", as: 'post_user_add'

# 検索
  get "/v1/1a3rd2x0/user/search", to: "users#search", as: 'user_search'

# 詳細
  get "/v1/0x2d0r31/user/:userId/:itemId", to: "users#edit", as: 'user_edit'
  post "/v1/0x2d0r31/user/:userId/:itemId", to: "users#update", as: 'post_user_edit'

# 論理削除
  get "/v1/0x2d0r31/user/:userId/:itemId/suspend", to: "users#suspend"
  post "/v1/0x2d0r31/user/:userId/:itemId/suspend", to: "users#suspend", as: 'user_suspend'

# API
  get '/v1/list', to: 'users#list', as: 'user_API'

# API更新
  get "/v1/hzu1822xR/fetch/API", to: "users#fetchAPI", as: 'fetch_API'


# ========
#　プラットフォーム
# ========

# 一覧
 get "/v1/jjs8192b/platform/create", to: "platform_lists#index", as: 'platform_list'

# API
 get '/v1/w5REzxSSkL/platform/list', to: 'platform_lists#list'


# ========
#　バナー
# ========

# 新規
  get "/v1/ev2x019rsE/banner/create", to: "banners#new", as: 'move_banners_create'
  post "/v1/ev2x019rsE/banner/create", to: "banners#create", as: 'post_banners_create'

# 一括本番公開／一括下書きに変更
  get "/v1/huA33bxZ/banner/change", to: "banners#change"
  post "/v1/huA33bxZ/banner/change", to: "banners#change", as: 'user_change_status'

# 削除
  get "/v1/Zxvc71sIe/banner/:itemId/destroy", to: "banners#destroy"
  post "/v1/Zxvc71sIe/banner/:itemId/destroy", to: "banners#destroy", as: 'banners_destroy'

# API
  get '/v1/rzE3tz68A/banner/list', to: 'banners#list'

# 一覧
  get "/v1/kks9912r0Z/banner/index", to: "banners#index", as: 'banners_index'

# ========
#　お知らせ
# ========

# 一覧
  get "/v1/wNOomn8lom/notice/index", to: "notice#index", as: 'notice_index'

# 新規
  get "/v1/luAieu368n/notice/create", to: "notice#new", as: 'move_notice_create'
  post "/v1/8boPfiohs4/notice/create", to: "notice#create", as: 'post_notice_create'

# 一括本番公開／一括下書きに変更
  get "/v1/2hjc0OAfmv/notice/:id/change", to: "notice#change"
  post "/v1/2hjc0OAfmv/notice/:id/change", to: "notice#change", as: 'notice_change'

# wy7y2POu8Z

# 編集
  get "/v1/l1d4Y5Zd7y/notice/:id/edit", to: "notice#edit", as: 'notice_edit'
  post "/v1/3sbPv8Ku71/notice/:id/update", to: "notice#update", as: 'post_notice_edit'

# 削除
  get "/v1/o4gquLY4h1/notice/:id/destroy", to: "notice#destroy", as: 'move_notice_destroy'
  post "/v1/h8jDN8ygn5/notice/:id/destroy", to: "notice#destroy", as: 'post_notice_destroy'

# API
  get "/v1/b3NQJEep4on/notice/list", to: 'notice#list', as: 'notice_list'

# API（最初の一件）
  get "/v1/no4pNQjE22y/notice/list/1st", to: "notice#first"

# API更新
  get "/v1/qch6cBXphu/notice/fetch/API", to: "notice#fetchAPI", as: 'notices_fetch_API'

# ========
#　バージョン／利用規約／プライバシーポリシー
# ========

# バージョン／利用規約／プライバシーポリシー　更新履歴一覧
  get "/v1/ksonxb26WejAS/version/index", to: "version#index", as: 'current_v_version_index'

# 新規（バージョン）
  get "/v1/t7ZXDeEEgH/version/create", to: "version#new", as: 'move_version_create'
  post "/v1/K7tTyggFRexA/version/create", to: "version#create", as: 'post_version_create'

# 新規（利用規約）
  get "/v1/38g3OoQf5V/terms/create", to: "terms#new", as: 'move_terms_create'
  post "/v1/KNPqVqKEa3/terms/create", to: "terms#create", as: 'post_terms_create'

# 新規（プライバシーポリシー）
  get "/v1/MVSyJEExDQ/privacy/create", to: "privacy#new", as: 'move_privacy_create'
  post "/v1/k8BvBMmTto/privacy/create", to: "privacy#create", as: 'post_privacy_create'
  
# API
  get "/v1/b0TgBY4on/version/list", to: 'version#list', as: 'version_list'

# ========
#　ログイン履歴
# ========

# ログイン履歴
  get "/v1/XmSe447Zz1q/login_history/index", to: "login_history#index", as: 'login_history_index'


end
