class TermsController < ApplicationController
  def new
    @term = Term.new
    render layout: "layouts/application"
  end

  def create
    @term = Term.new(terms_params)
    
    if @term.save
      redirect_to current_v_version_index_path
    else
      render :new, layout: "layouts/application"
    end
  end

  def terms_params
    params.require(:term).permit(
      :version,
      :content
    )
  end
end
