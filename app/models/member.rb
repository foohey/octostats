class Member < ActiveRecord::Base
  has_and_belongs_to_many :organizations
  has_many :commits
end
