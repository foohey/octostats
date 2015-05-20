class CreatePullRequests < ActiveRecord::Migration
  def change
    create_table :pull_requests do |t|
      t.references :repository, index: true, foreign_key: true
      t.references :member, index: true, foreign_key: true
      t.integer :number
      t.string :state
      t.boolean :locked
      t.string :title
      t.text :body
      t.datetime :github_created_at
      t.datetime :github_updated_at
      t.datetime :github_closed_at
      t.datetime :github_merged_at

      t.timestamps null: false
    end
  end
end
