class UsersController < ApplicationController

  hobo_user_controller
  include HoboOmniauth::Controller

  auto_actions :all, :except => [ :new, :create ]
end
