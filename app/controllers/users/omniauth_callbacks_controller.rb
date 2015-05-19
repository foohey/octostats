class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def github
    oauth_data = request.env["omniauth.auth"]
    @user = User.from_github( oauth_data )

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message :notice, :success, kind: :github if is_navigational_format?

      update_data
    else
      # handle exceptions
    end

  end

private

  def update_data
    client = Octokit::Client.new( access_token: current_user.github_token )

    client.orgs.each do |org|

      db_org = current_user.organizations.where( login: org[ :login ] ).first_or_create do |o|
        o.avatar_url = org[ :avatar_url ]
        current_user.organizations << o
      end

      client.organization_members( db_org.login ).each do |m|
        db_org.members.where( login: m[ :login ] ).first_or_create do |db_m|
          db_m.avatar_url = m[ :avatar_url ]
          db_org.members << db_m
        end
      end
    end
  end

end
