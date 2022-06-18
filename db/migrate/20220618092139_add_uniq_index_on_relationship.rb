class AddUniqIndexOnRelationship < ActiveRecord::Migration[7.0]
  disable_ddl_transaction!

  def change
    add_index :relationships, [:followee_id, :follower_id], unique: true, algorithm: :concurrently
  end
end
