# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  context 'when user has many clock_ins' do
    let(:user) { create(:user) }
    before { create_list(:clock_in, 5, user: user) }

    it 'destroy the users clock_ins when user is destroyed' do
      expect { user.destroy }.to change { ClockIn.count }.by(-5)
    end
  end

  describe 'followship' do
    let(:this_user) { create(:user) }
    let(:other_user_1) { create(:user) }
    let(:other_user_2) { create(:user) }

    describe '#followees' do
      context 'this user follows other users' do
        before do
          create(:relationship, follower_id: this_user.id, followee_id: other_user_1.id)
          create(:relationship, follower_id: this_user.id, followee_id: other_user_2.id)
        end

        it 'returns all followees' do
          expect(this_user.followees.pluck(:id)).to match_array([other_user_1.id, other_user_2.id])
        end
      end
    end

    describe '#followers' do
      context 'this user followed by other users' do
        before do
          create(:relationship, follower_id: other_user_1.id, followee_id: this_user.id)
          create(:relationship, follower_id: other_user_2.id, followee_id: this_user.id)
        end

        it 'returns all followers' do
          expect(this_user.followers.pluck(:id)).to match_array([other_user_1.id, other_user_2.id])
        end
      end
    end
  end
end
