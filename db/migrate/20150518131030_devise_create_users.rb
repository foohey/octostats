class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      ## Github user infos
      t.string :github_uid
      t.string :github_token
      t.string :github_login
      t.string :github_email

      t.timestamps
    end

    add_index :users, :github_uid, unique: true
  end
end
