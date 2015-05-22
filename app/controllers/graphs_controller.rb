class GraphsController < ApplicationController
  before_action :load_organization

  def index
  end

  def commits
    week_days = ( Date.current.beginning_of_week .. Date.current.end_of_week )

    commits = week_days.map do |day|
      Commit.on( day ).count
    end

    respond_to do |format|
      format.html
      format.json {
        render json: commits
      }
    end
  end

  def contributors
  end

private

  def load_organization
    @organization = Organization.find_by( login: params[ :organization_id ] )
  end

end
