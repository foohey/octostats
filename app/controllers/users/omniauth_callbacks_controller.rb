class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    oauth_data = request.env["omniauth.auth"]
    @user = User.from_github( oauth_data )

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message :notice, :success, kind: :github if is_navigational_format?
    else
      # handle exceptions
    end

  end

end
