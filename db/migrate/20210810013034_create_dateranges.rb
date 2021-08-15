class CreateDateranges < ActiveRecord::Migration[6.1]
  def change
    create_table :dateranges do |t|
      t.string :name
      t.date :startDate
      t.date :endDate
      t.json :data
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
