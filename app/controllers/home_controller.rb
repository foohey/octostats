class HomeController < ApplicationController

  def login
    if user_signed_in?
      redirect_to root_path
    end
  end

end
