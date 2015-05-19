class MembersController < ApplicationController
  def index
    @organization = Organization.find_by( login: params[ :id ] )

    respond_to do |format|
      format.json {
        render json: @organization.members
      }
    end
  end
end
