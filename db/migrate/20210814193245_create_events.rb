class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :description
      t.datetime :startTime
      t.datetime :endTime
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
