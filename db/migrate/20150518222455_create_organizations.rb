class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :login
      t.string :avatar_url
      t.text :description

      t.timestamps null: false
    end
  end
end
