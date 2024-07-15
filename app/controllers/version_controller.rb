class VersionController < ApplicationController
  before_action :logged_in?
  skip_before_action :logged_in?, only: %i[list]

  def list
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

  def index
    @versions = Version.all.order(created_at: "DESC")
    @terms = Term.all.order(created_at: "DESC")
    @privacies = Privacy.all.order(created_at: "DESC")
    render layout: "layouts/application"
  end

  def new
    @version = Version.new
    render layout: "layouts/application"
  end

  def create
    @version = Version.new(version_params)
    
    if @version.save
      redirect_to current_v_version_index_path
    else
      render :new, layout: "layouts/application"
    end
  end

  def version_params
    params.require(:version).permit(
      :version,
      :content
    )
  end
end
