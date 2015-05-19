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
        o.avatar_url  = org[ :avatar_url ]
        o.description = org[ :description ]
        current_user.organizations << o
      end

      client.organization_members( db_org.login ).each do |m|
        db_org.members.where( login: m[ :login ] ).first_or_create do |db_m|
          db_m.avatar_url = m[ :avatar_url ]
          db_org.members << db_m
        end
      end

      client.repositories( db_org.login ).each do |repo|
        db_org.repositories.where( name: repo[ :name ] ).first_or_create do |db_repo|
          db_repo.description    = repo[ :description ]
          db_repo.homepage       = repo[ :homepage ]
          db_repo.is_private     = repo[ :private ]
          db_repo.is_fork        = repo[ :fork ]
          db_repo.forks_count    = repo[ :forks ]
          db_repo.watchers_count = repo[ :watchers ]
        end
      end
    end
  end

end
