class AddCategoryToClockIns < ActiveRecord::Migration[7.0]
  def change
    add_column :clock_ins, :category, :text
  end
end
