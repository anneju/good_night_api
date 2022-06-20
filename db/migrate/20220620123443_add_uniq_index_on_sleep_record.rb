class AddUniqIndexOnSleepRecord < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :sleep_records, [:sleep_clock_in_id, :wake_up_clock_in_id], unique: true, name: 'index_sleep_records_on_sleep_id_and_wake_up_id', algorithm: :concurrently
  end
end
