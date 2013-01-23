class UsersController < ApplicationController

  hobo_user_controller
  include HoboOmniauth::Controller

  auto_actions :all, :except => [ :new, :create ]

  def omniauth_callback
    if session[:github_redirect]
      redirect_to "https://github.com/#{session[:github_redirect]}"
    else
      redirect_to '/'
    end
  end

end
