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

    ## Fetch organizations
    client.orgs.each do |org|
      db_org = current_user.organizations.where( login: org[ :login ] ).first_or_create do |o|
        o.avatar_url  = org[ :avatar_url ]
        o.description = org[ :description ]
        current_user.organizations << o
      end

      ## Fetch members
      client.organization_members( db_org.login ).each do |m|
        db_org.members.where( login: m[ :login ] ).first_or_create do |db_m|
          db_m.avatar_url = m[ :avatar_url ]
          db_org.members << db_m
        end
      end


      ## Fetch repositories
      client.repositories( db_org.login ).each do |repo|
        db_org.repositories.where( name: repo[ :name ] ).first_or_create do |db_repo|
          db_repo.description    = repo[ :description ]
          db_repo.homepage       = repo[ :homepage ]
          db_repo.is_private     = repo[ :private ]
          db_repo.is_fork        = repo[ :fork ]
          db_repo.forks_count    = repo[ :forks ]
          db_repo.watchers_count = repo[ :watchers ]

          ## Fetch pull requests
          client.pull_requests( "#{ db_org.login }/#{ db_repo.name }" ).each do |pr|
            member = db_org.members.find_by( login: pr[ :user ][ :login ] )

            db_pr = db_repo.pull_requests.where( number: pr[ :number ] ).first_or_create do |dpr|
              dpr.repository = db_repo

              if member
                dpr.member = member
              end

              dpr.state  = pr[ :state ]
              dpr.locked = pr[ :locked ]
              dpr.title  = pr[ :title ]
              dpr.body   = pr[ :body ]
              dpr.github_created_at = pr[ :created_at ]
              dpr.github_updated_at = pr[ :updated_at ]
              dpr.github_merged_at = pr[ :merged_at ]
              dpr.github_closed_at = pr[ :closed_at ]
            end

          end

          ## Fetch commits
          client.commits( "#{ db_org.login }/#{ db_repo.name }" ).each do |commit|

            # Check for member
            member = db_org.members.find_by( login: commit[ :author ][ :login ] )

            db_commit = Commit.where( sha: commit[ :sha ] ).first_or_create do |cm|
              cm.committer_name  = commit[ :commit ][ :author ][ :name ]
              cm.committer_email = commit[ :commit ][ :author ][ :email ]
              cm.commit_at       = commit[ :commit ][ :author ][ :date ]
              cm.message         = commit[ :commit ][ :message ]
              cm.github_login    = commit[ :author ][ :login ]

              cm.repository = db_repo

              if member
                cm.member = member
              end

            end


          end
        end

      end
    end
  end

end
