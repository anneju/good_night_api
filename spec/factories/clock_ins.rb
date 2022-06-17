# == Schema Information
#
# Table name: clock_ins
#
#  id         :bigint           not null, primary key
#  type       :text
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
FactoryBot.define do
  factory :clock_in do
    user { create(:user) }
    type { ['sleep', 'wake_up'].sample }

    trait :sleep do
      type { 'sleep' }
    end

    trait :wake_up do
      type { 'wake_up' }
    end
  end
end
