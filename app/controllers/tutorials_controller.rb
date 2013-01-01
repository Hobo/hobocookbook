class TutorialsController < ApplicationController

  DOC_ROOT     = `bundle show doc`.strip
  caches_page :show

  def index
    redirect_to :action => "show", :tutorial => "toc"
  end

  def show
    tutorial     = params[:tutorial].gsub(/[^a-z0-9_\-]/, '')
    filename     = "tutorials/#{tutorial}.markdown"
    @content     = HoboFields::Types::MarkdownString.new(File.read("#{DOC_ROOT}/#{filename}"))
    @title       = @content.split("\n").first.gsub(/^# /, '')
    @last_update = last_update filename
    if tutorial=='agility' || tutorial=='gitorial'
      @edit_link = nil
    else
      @edit_link  = "https://github.com/Hobo/hobodoc/edit/master/doc/tutorials/#{tutorial}.markdown"
    end

    @sidebar = Maruku.new(File.read("#{DOC_ROOT}/tutorials/sidebar.markdown")).to_html.html_safe

    @content = Maruku.new(@content).to_html

    @content = ApiTagDef.linkify(@content) do |tag|
      "<a href='/tagdef/#{tag.taglib.plugin.name}/#{tag.taglib.name}/#{tag.tag}'>&lt;#{tag.tag}&gt;</a>"
    end.html_safe
  end

end
