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
FactoryBot.define do
  factory :clock_in do
    user { create(:user) }
    category { ['sleep', 'wake_up'].sample }

    trait :sleep do
      category { 'sleep' }
    end

    trait :wake_up do
      category { 'wake_up' }
    end
  end
end
