class HomeController < ApplicationController
    def index
      @users = User.all.count
      render json:  +@users
    end
  end