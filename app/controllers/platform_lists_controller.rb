class PlatformListsController < ApplicationController
  before_action :set_platform_list, only: %i[ show update destroy ]
  before_action :logged_in?
  skip_before_action :logged_in?, only: %i[list]

  def list
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
  
  def index
    @platform_lists = Platform.all
    render :layout => "layouts/application"
  end

  def show
  end

  def create

  end

  def update

  end

  def destroy

  end

  private

    def platform_list_params
    end
end
