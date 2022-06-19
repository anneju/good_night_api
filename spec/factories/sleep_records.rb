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
FactoryBot.define do
  factory :sleep_record do
    duration { 1 }
    sleep_clock_in_id { "" }
    wake_up_clock_in_id { "" }
    user { nil }
  end
end
