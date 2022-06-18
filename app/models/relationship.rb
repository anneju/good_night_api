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
# Indexes
#
#  index_relationships_on_followee_id_and_follower_id  (followee_id,follower_id) UNIQUE
#
class Relationship < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  validates :followee_id, uniqueness: { scope: :follower_id }
end
