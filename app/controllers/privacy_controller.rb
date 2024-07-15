class PrivacyController < ApplicationController
  def new
    @privacy = Privacy.new
    render layout: "layouts/application"
  end

  def create
    @privacy = Privacy.new(privacy_params)
    
    if @privacy.save
      redirect_to current_v_version_index_path
    else
      render :new, layout: "layouts/application"
    end
  end

  def privacy_params
    params.require(:privacy).permit(
      :version,
      :content
    )
  end
end
