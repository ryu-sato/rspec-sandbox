class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.references :user, foreign_key: true

      t.timestamps
      t.integer :lock_version
    end
    add_index :projects, :name
  end
end
