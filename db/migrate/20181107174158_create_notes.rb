class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true
      t.text :message

      t.timestamps
      t.integer :lock_version
    end
  end
end
