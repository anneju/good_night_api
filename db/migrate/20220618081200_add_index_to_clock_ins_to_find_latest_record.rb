class AddIndexToClockInsToFindLatestRecord < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :clock_ins, [:user_id, :created_at], algorithm: :concurrently
  end
end
