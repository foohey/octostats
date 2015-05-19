class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.integer :organization_id

      t.string  :name
      t.text    :description
      t.string  :homepage
      t.boolean :is_private
      t.boolean :is_fork
      t.integer :forks_count,    default: 0
      t.integer :watchers_count, default: 0

      t.timestamps null: false
    end
  end
end
