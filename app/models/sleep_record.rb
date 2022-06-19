# == Schema Information
#
# Table name: sleep_records
#
#  id                  :bigint           not null, primary key
#  duration            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  sleep_clock_in_id   :bigint
#  user_id             :bigint           not null
#  wake_up_clock_in_id :bigint
#
# Indexes
#
#  index_sleep_records_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class SleepRecord < ApplicationRecord
  validates :duration, presence: true

  belongs_to :user
  belongs_to :sleep_clock_in, class_name: 'ClockIn', foreign_key: :sleep_clock_in_id
  belongs_to :wake_up_clock_in, class_name: 'ClockIn', foreign_key: :wake_up_clock_in_id

  before_validation :calculation_duration, on: :create

  private

  def calculation_duration
    self.duration = (wake_up_clock_in.created_at - sleep_clock_in.created_at).to_i
  end
end
