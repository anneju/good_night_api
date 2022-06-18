class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.bigint :follower_id
      t.bigint :followee_id

      t.timestamps
    end
  end
end
