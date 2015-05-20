class GraphsController < ApplicationController
  def index
    @organization = Organization.find_by( login: params[ :organization_id ] )
  end
end
