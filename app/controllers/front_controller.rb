class FrontController < ApplicationController

  hobo_controller

  skip_before_filter :verify_authenticity_token, :only => [:search]

  def index
    redirect_to :controller => :manual, :section => :toc, :action => :manual_section
  end

  def search
    if params[:query]
      site_search(params[:query])
    end
  end

end
