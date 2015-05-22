class Commit < ActiveRecord::Base

  belongs_to :member
  belongs_to :repository

  scope :on, ->( date ) { where( "DATE(commits.commit_at) = ?", date ) }

end
