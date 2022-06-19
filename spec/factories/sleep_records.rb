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
    before(:create) do |sr|
      user = sr.user || create(:user)
      sr.user = user
      sr.sleep_clock_in = user.clock_ins.create(created_at: 10.minutes.ago)
      sr.wake_up_clock_in = user.clock_ins.create(created_at: Time.now)
    end
  end
end
