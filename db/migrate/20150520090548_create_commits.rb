class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string     :sha
      t.string     :committer_name
      t.string     :committer_email
      t.datetime   :commit_at
      t.text       :message
      t.string     :github_login

      t.references :member, index: true, foreign_key: true
      t.references :repository, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
