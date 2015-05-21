class CommitsController < ApplicationController
  def index
    @organization = Organization.find_by( login: params[ :organization_id ] )
    @commits      = @organization.commits.order( 'commit_at DESC' )
  end
end
