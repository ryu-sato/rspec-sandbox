class CreateDiffs < ActiveRecord::Migration[5.2]
  def change
    create_table :diffs do |t|
      t.string :diff, null: false

      t.timestamps
      t.integer :lock_version
    end
  end
end
