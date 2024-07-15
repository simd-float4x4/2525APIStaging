class BannersController < ApplicationController
  before_action :logged_in?
  skip_before_action :logged_in?, only: %i[list]

    def list
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
  
    def index
      @banners = Banner.all
      render layout: "layouts/application"
    end
  
    def new
      @banner = Banner.new
      render layout: "layouts/application"
    end
  
    def create
      @banner = Banner.new(banner_params)
  
      if @banner.save
        redirect_to banners_index_path
      else
        render :new, layout: "layouts/application"
      end
    end

    def change
      @banners = Banner.all
      thisBool = @banners.first.hasPublished
      @banners.map do |b|
        b.hasPublished = thisBool ? false : true
        b.save
      end

      redirect_to banners_index_path
    end

    def destroy
        @banner = Banner.find(params[:itemId])
        @banner.destroy
        redirect_to banners_index_path
    end
  
    private
  
    def banner_params
        params.require(:banner).permit(
            :image, 
            :imageSortNumber, 
            :imageURL, 
            :imageTitle,
            :transitionURL
        )
    end
  end
  