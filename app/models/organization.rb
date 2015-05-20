class Organization < ActiveRecord::Base
  has_and_belongs_to_many :members

  # TODO: We should scope repos depending on user allowed repos!
  has_many :repositories

  has_many :commits,       through: :members
  has_many :pull_requests, through: :repositories
end
