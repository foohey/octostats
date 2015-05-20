class HomeController < ApplicationController
  layout 'sign_in'

  def login
    if user_signed_in?
      redirect_to root_path
    end
  end

end
