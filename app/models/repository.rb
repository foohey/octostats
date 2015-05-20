class Repository < ActiveRecord::Base

  has_many :commits
  has_many :pull_requests

end
