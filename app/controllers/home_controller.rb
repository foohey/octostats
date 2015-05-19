class HomeController < ApplicationController
  before_filter :authenticate_user!, except: :login

  def index
    @organizations = current_user.organizations.all
  end

  def login
    if user_signed_in?
      redirect_to root_path
    end
  end

end
