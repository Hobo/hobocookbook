class ManualController < ApplicationController
  caches_page :manual_section, :manual_subsection, :home
  def manual_section
    @this = ManualSection.find_by_slug(params[:section])
  end

  def manual_subsection
    @this = ManualSubsection.find_by_slug("#{params[:section]}/#{params[:subsection]}")
  end

  def index
    redirect_to :action => "manual_section", :section => "toc"
  end

  def home
    @this = ManualSection.find_by_slug('home')
    @left = ManualSection.find_by_slug('what-is-hobo')
    @middle = ManualSection.find_by_slug('gallery')
    @right = ManualSection.find_by_slug('dive-in')
  end
end
