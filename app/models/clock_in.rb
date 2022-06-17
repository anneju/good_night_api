# == Schema Information
#
# Table name: clock_ins
#
#  id         :bigint           not null, primary key
#  category   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_clock_ins_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ClockIn < ApplicationRecord
  self.ignored_columns = ["type"]

  belongs_to :user

  validates :category, inclusion: { in: %w(sleep wake_up), message: "%{value} is not a valid category" }
end
