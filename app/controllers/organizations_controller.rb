class OrganizationsController < ApplicationController
  def index
    @organizations = current_user.organizations.all
    respond_to do |format|
      format.html
      format.json {
        render json: @organizations
      }
    end
  end

  def show
    @organization = Organization.find_by login: params[ :id ]

    respond_to do |format|
      format.html
      format.json {
        render json: @organization
      }
    end
  end
end
