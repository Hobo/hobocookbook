class BlogController < ApplicationController
  caches_page :blog, :index

  def index
    params[:slug] = ''
    if request.format.html?
      @this = Blog.limit(5)
    else
      @this = Blog.all
    end
    blog_common
  end

  def blog
    params[:slug] = params[:slug].chomp("/").gsub("/", "-").sub("-", "/").sub("-", "/")
    if params[:slug].starts_with?("category-")
      category = params[:slug].gsub("category-","").titleize
      @this = Blog.all.select {|blog| blog.metadata['categories'].include?(category)}
    else
      @this = Blog.where('slug LIKE ?', "#{params[:slug]}%")
    end
    blog_common
  end

  def blog_common
    respond_to do |format|
      format.html do
        if @this.length==0
          raise ActiveRecord::RecordNotFound
        elsif @this.length==1
          @this = @this.first
          render :show
        else
          render :index
        end
      end
      format.xml { render :atom }
      format.atom { render :atom }
    end
  end
end
