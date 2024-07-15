class ApplicationController < ActionController::API
    before_action :set_request_variant
    before_action :require_donut_session

    def index
        request.user_agent       #=> "Mozilla/5.0 (Macintosh; ..."
        request.device_type      #=> :pc
        request.os               #=> "Mac OSX"
        request.browser          #=> "Chrome"
        request.from_pc?         #=> true
        request.from_smartphone? #=> false
    end

    private
  
    def require_donut_session
      unless session[:donut_id]
        redirect_to login_sessions_path # リダイレクト先を適切に設定してください
      end
    end

    # It is useful for Action Pack variants, which is new feature from Rails 4.1.
    # You can switch view templates by +pc or +smartphone in file name.
    # http://guides.rubyonrails.org/4_1_release_notes.html#action-pack-variants
    def set_request_variant
        request.variant = request.device_variant # :pc, :smartphone
    end
end