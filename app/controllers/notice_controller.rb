class NoticeController < ApplicationController
  before_action :logged_in?
  skip_before_action :logged_in?, only: %i[list, first]

      def list
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

      def first
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

      def index
        @notices = Notice.all.order(created_at: "DESC")
        @version = Version.first
        render layout: "layouts/application"
      end
    
      def new
        @notice = Notice.new
        render layout: "layouts/application"
      end
    
      def create
        @notice = Notice.new(notice_params)
    
        if @notice.save
          redirect_to notice_index_path
        else
          render :new, layout: "layouts/application"
        end
      end

      def edit
        @notice = Notice.find(params[:id])
        render :edit, layout: "layouts/application"
      end
     
      def update
        @notice = Notice.find(params[:id])
  
        if @notice.update(notice_params)
          redirect_to notice_index_path
        else
          render :edit, layout: "layouts/application"
        end
      end
  
  
      def change
        @notice = Notice.find(params[:id])
        @notice.hasPublished = @notice.hasPublished == true ? false : true
        @notice.save

        redirect_to notice_index_path
      end
  
      def destroy
        @notice = Notice.find(params[:id])
        @notice.destroy
        redirect_to notice_index_path
      end

      private
    
      def notice_params
          params.require(:notice).permit(
            :title,
            :date,
            :body,
            :mainCategory,
            :hasPublished
          )
      end
end
