class CreateClockIns < ActiveRecord::Migration[7.0]
  def change
    create_table :clock_ins do |t|
      t.references :user, null: false, foreign_key: true
      t.text :type

      t.timestamps
    end
  end
end
