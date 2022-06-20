class CreateSleepRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :sleep_records do |t|
      t.integer :duration
      t.bigint :sleep_clock_in_id
      t.bigint :wake_up_clock_in_id
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
