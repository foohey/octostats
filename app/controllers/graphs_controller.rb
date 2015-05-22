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
    #
    # query = %Q{
    #   SELECT d.commit_at, count(c.id) FROM (
    #     SELECT dates AS commit_at
    #     FROM generate_series( date( ( SELECT commit_at FROM commits ORDER BY commit_at ASC LIMIT 1 ) ), date(now()), '1d' )
    #     AS dates
    #   ) d
    #   LEFT OUTER JOIN commits c ON to_char(d.commit_at, 'YYYY-MM-DD') = to_char(date(c.commit_at), 'YYYY-MM-DD')
    #   GROUP BY d.commit_at
    #   ORDER BY d.commit_at
    # }

    query = %Q{
      SELECT d.commit_at, count(c.id) FROM (
        SELECT dates AS commit_at
        FROM generate_series( date( ( SELECT commit_at FROM commits ORDER BY commit_at ASC LIMIT 1 ) ), date(now()), '1d' )
        AS dates
      ) d
      LEFT OUTER JOIN commits c ON to_char(d.commit_at, 'YYYY-MM-DD') = to_char(date(c.commit_at), 'YYYY-MM-DD') AND c.member_id = ?
      GROUP BY d.commit_at
      ORDER BY d.commit_at
    }

    respond_to do |format|
      format.html
      format.json do
        # commits = Commit.find_by_sql( [query, 7] )

        commits = @organization.members.map { |m|
          { login: m.login, commits: m.commits.find_by_sql( [query, m.id] ) }
        }

        render json: commits
      end
    end


  end

  def code_frequency
  end

private

  def load_organization
    @organization = Organization.find_by( login: params[ :organization_id ] )
  end

end
