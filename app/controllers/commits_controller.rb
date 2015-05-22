class CommitsController < ApplicationController
  def index
    @organization = Organization.find_by( login: params[ :organization_id ] )
    @commits      = @organization.commits.order( 'commit_at DESC' )

    respond_to do |format|
      format.html
      format.json {
        render json: @commits
      }
    end
  end
end