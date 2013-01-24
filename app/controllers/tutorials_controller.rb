class TutorialsController < ApplicationController
  caches_page :show

  def index
    redirect_to :action => "show", :tutorial => "recipes"
  end

  def show
    @this = Tutorial.find_by_slug(params[:tutorial])
    @sidebar = Tutorial.find_by_slug("sidebar")
  end

  def screencast
    @sidebar = Tutorial.find_by_slug("sidebar")
  end
end
