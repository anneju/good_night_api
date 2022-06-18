# == Schema Information
#
# Table name: relationships
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followee_id :bigint
#  follower_id :bigint
#
FactoryBot.define do
  factory :relationship do
    follower_id { create(:user).id }
    followee_id { create(:user).id }
  end
end
