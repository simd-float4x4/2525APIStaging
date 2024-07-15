class DonutController < ApplicationController
    before_action :set_request_variant
    skip_before_action :require_donut_session, only: [:index, :create]
    before_action :logged_in?, only: [:index, :create]

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

    private
    def set_request_variant
        request.variant = request.device_type # :pc, :smartphone, etc
    end
 
    def logged_in?
        if session[:donut_id]
            @donut = Donut.find(session[:donut_id])
            redirect_to user_list_path
        end
    end
end