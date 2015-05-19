class CreateMembersOrganizationsTable < ActiveRecord::Migration
  def change
    create_table :members_organizations, id: false do |t|
      t.belongs_to :organization, index: true
      t.belongs_to :member,       index: true
    end
  end
end
