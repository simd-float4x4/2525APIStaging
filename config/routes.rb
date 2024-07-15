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
#　ユーザー
# ========

# 一覧
  get '/0x2d0r31/v1/user/index', to: "users#index", as: 'user_list'

# 新規
  get "/xy76Za109b/v1/user/create", to: "users#new", as: 'move_user_create'
  post "/xy76Za109b/v1/user/create", to: "users#create", as: 'post_user_create'

# ハッシュタグ
  get "/uKu3Hdwj7i/v1/user/hash_tag", to: "users#hash", as: 'user_hashtag_search'
  # post "/SF6Jbs0O1y/v1/user/searching", to: "users#hash", as: 'user_sending'

# ユーザにUserPlatFormを追加
  get "/MqahkHTHbC/v1/user/add", to: "users#add", as: 'move_user_add'
  post "/YqFlFOKvVu/v1/user/insert", to: "users#berry", as: 'post_user_add'

# 検索
  get "/1a3rd2x0/v1/user/search", to: "users#search", as: 'user_search'

# 詳細
  get "/0x2d0r31/v1/user/:userId/:itemId", to: "users#edit", as: 'user_edit'
  post "/0x2d0r31/v1/user/:userId/:itemId", to: "users#update", as: 'post_user_edit'

# 論理削除
  get "/0x2d0r31/v1/user/:userId/:itemId/suspend", to: "users#suspend"
  post "/0x2d0r31/v1/user/:userId/:itemId/suspend", to: "users#suspend", as: 'user_suspend'

# API
  get '/list', to: 'users#list', as: 'user_API'

# API更新
  get "/hzu1822xR/v1/fetch/API", to: "users#fetchAPI", as: 'fetch_API'


# ========
#　プラットフォーム
# ========

# 一覧
 get "/jjs8192b/v1/platform/create", to: "platform_lists#index", as: 'platform_list'

# API
 get '/w5REzxSSkL/v1/platform/list', to: 'platform_lists#list'


# ========
#　バナー
# ========

# 新規
  get "/ev2x019rsE/v1/banner/create", to: "banners#new", as: 'move_banners_create'
  post "/ev2x019rsE/v1/banner/create", to: "banners#create", as: 'post_banners_create'

# 一括本番公開／一括下書きに変更
  get "/huA33bxZ/v1/banner/change", to: "banners#change"
  post "/huA33bxZ/v1/banner/change", to: "banners#change", as: 'user_change_status'

# 削除
  get "/Zxvc71sIe/v1/banner/:itemId/destroy", to: "banners#destroy"
  post "/Zxvc71sIe/v1/banner/:itemId/destroy", to: "banners#destroy", as: 'banners_destroy'

# API
  get '/rzE3tz68A/v1/banner/list', to: 'banners#list'

# 一覧
  get "/kks9912r0Z/v1/banner/index", to: "banners#index", as: 'banners_index'

# ========
#　お知らせ
# ========

# 一覧
  get "/wNOomn8lom/v1/notice/index", to: "notice#index", as: 'notice_index'

# 新規
  get "/luAieu368n/v1/notice/create", to: "notice#new", as: 'move_notice_create'
  post "/8boPfiohs4/v1/notice/create", to: "notice#create", as: 'post_notice_create'

# 一括本番公開／一括下書きに変更
  get "/2hjc0OAfmv/v1/notice/:id/change", to: "notice#change"
  post "/2hjc0OAfmv/v1/notice/:id/change", to: "notice#change", as: 'notice_change'

# wy7y2POu8Z

# 編集
  get "/l1d4Y5Zd7y/v1/notice/:id/edit", to: "notice#edit", as: 'notice_edit'
  post "/3sbPv8Ku71/v1/notice/:id/update", to: "notice#update", as: 'post_notice_edit'

# 削除
  get "/o4gquLY4h1/v1/notice/:id/destroy", to: "notice#destroy", as: 'move_notice_destroy'
  post "/h8jDN8ygn5/v1/notice/:id/destroy", to: "notice#destroy", as: 'post_notice_destroy'

# API
  get "/b3NQJEep4on/v1/notice/list", to: 'notice#list', as: 'notice_list'

# API（最初の一件）
  get "/no4pNQjE22y/v1/notice/list/1st", to: "notice#first"

# API更新
  get "/qch6cBXphu/v1/notice/fetch/API", to: "notice#fetchAPI", as: 'notices_fetch_API'

# ========
#　バージョン／利用規約／プライバシーポリシー
# ========

# バージョン／利用規約／プライバシーポリシー　更新履歴一覧
  get "/ksonxb26WejAS/v1/version/index", to: "version#index", as: 'current_v_version_index'

# 新規（バージョン）
  get "/t7ZXDeEEgH/v1/version/create", to: "version#new", as: 'move_version_create'
  post "/K7tTyggFRexA/v1/version/create", to: "version#create", as: 'post_version_create'

# 新規（利用規約）
  get "/38g3OoQf5V/v1/terms/create", to: "terms#new", as: 'move_terms_create'
  post "/KNPqVqKEa3/v1/terms/create", to: "terms#create", as: 'post_terms_create'

# 新規（プライバシーポリシー）
  get "/MVSyJEExDQ/v1/privacy/create", to: "privacy#new", as: 'move_privacy_create'
  post "/k8BvBMmTto/v1/privacy/create", to: "privacy#create", as: 'post_privacy_create'
  
# API
  get "/b0TgBY4on/v1/version/list", to: 'version#list', as: 'version_list'

# ========
#　ログイン履歴
# ========

# ログイン履歴
  get "/XmSe447Zz1q/v1/login_history/index", to: "login_history#index", as: 'login_history_index'


end
