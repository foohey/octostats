class MembersController < ApplicationController
  def index
    @organization = Organization.find_by( login: params[ :organization_id ] )

    respond_to do |format|
      format.html
      format.json {
        render json: @organization.members
      }
    end
  end
end
