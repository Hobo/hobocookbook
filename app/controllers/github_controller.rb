class GithubController < ApplicationController
  def github
    session[:github_redirect]=params[:uri]
    redirect_to '/auth/github'
  end
end
