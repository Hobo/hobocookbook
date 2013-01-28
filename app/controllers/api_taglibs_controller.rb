class ApiTaglibsController < ApplicationController

  hobo_model_controller

  caches_page :show

  auto_actions :show

  def show
    if params[:id] =~ /^rapid_(.*)/
      params[:id] = $1
    end
    hobo_show
  end

end
