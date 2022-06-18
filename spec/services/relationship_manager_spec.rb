require 'rails_helper'

RSpec.describe RelationshipManager do
  let(:current_user) { create(:user) }
  let(:target_user) { create(:user) }

  subject { RelationshipManager.new(current_user: current_user, target_user: target_user) }

  describe '#process' do
    describe 'when current_user is not following target_user' do
      it 'have current_user start follow target_user' do
        result = subject.process

        expect(result).to be_truthy
        expect(current_user.followees.pluck(:id)).to include(target_user.id)
      end
    end

    describe 'when current_user is already following target_user' do
      before { create(:relationship, follower: current_user, followee: target_user) }
      it 'have current_user unfollow target_user' do
        result = subject.process

        expect(result).to be_truthy
        expect(current_user.followees.pluck(:id)).not_to include(target_user.id)
      end
    end
  end
end
