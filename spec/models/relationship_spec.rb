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
require 'rails_helper'

RSpec.describe Relationship, type: :model do
  it { is_expected.to validate_uniqueness_of(:followee_id).scoped_to(:follower_id) }
end
