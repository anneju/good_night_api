shared_context 'when_current_user_is_following_other_users' do
  let(:current_user) { create(:user) }
  let(:other_user_1) { create(:user) }
  let(:other_user_2) { create(:user) }

  before do
    create(:relationship, follower: current_user, followee: other_user_1)
    create(:relationship, follower: current_user, followee: other_user_2)
  end
end

shared_context 'when_current_user_is_followed_by_other_users' do
  let(:current_user) { create(:user) }
  let(:other_user_1) { create(:user) }
  let(:other_user_2) { create(:user) }

  before do
    create(:relationship, follower: other_user_1, followee: current_user)
    create(:relationship, follower: other_user_2, followee: current_user)
  end
end
