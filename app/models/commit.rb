class Commit < ActiveRecord::Base

  belongs_to :member

  scope :on, ->( date ) { where( "DATE(commits.commit_at) = ?", date ) }

end
