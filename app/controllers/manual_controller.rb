class ManualController < ApplicationController
  caches_page :manual_section, :manual_subsection
  def manual_section
    @this = ManualSection.find_by_slug(params[:section])
  end

  def manual_subsection
    @this = ManualSubsection.find_by_slug("#{params[:section]}/#{params[:subsection]}")
  end

  def index
    redirect_to :action => "manual_section", :section => "toc"
  end
end

