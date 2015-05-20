class CommitsController < ApplicationController
  def index
    @organization = Organization.find_by( login: params[ :organization_id ] )
    #byebug
  end
end
