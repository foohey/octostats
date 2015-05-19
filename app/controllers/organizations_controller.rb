class OrganizationsController < ApplicationController
  def show
    @organization = Organization.find_by login: params[ :org_login ]
  end
end
