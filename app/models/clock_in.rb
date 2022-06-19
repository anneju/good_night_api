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
#  index_clock_ins_on_user_id                 (user_id)
#  index_clock_ins_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ClockIn < ApplicationRecord
  SLEEP = 'sleep'.freeze
  WAKEUP = 'wake_up'.freeze

  scope :sleep, -> { where(category: SLEEP) }
  scope :wake_up, -> { where(category: WAKEUP) }

  belongs_to :user

  validates :category, inclusion: { in: %w(sleep wake_up), message: "%{value} is not a valid category" }

  before_validation :set_category, on: :create
  after_commit -> { SleepRecordCreateWorker.perform_async(id) }, if: :wake_up?

  private

  def sleep?
    self.category == SLEEP
  end

  def wake_up?
    self.category == WAKEUP
  end

  def set_category
    self.category = user.lastest_clock_in&.category == SLEEP ? WAKEUP : SLEEP
  end
end
