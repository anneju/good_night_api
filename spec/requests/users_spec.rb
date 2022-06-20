require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:current_user) { create(:user) }

  describe 'POST /touch_relationship' do
    let(:target_user) { create(:user) }

    context 'when param is valid' do
      it 'returns 201 status and create a clock_in record' do
        post "/users/#{current_user.id}/touch_relationship/#{target_user.id}"

        expect(response.status).to eq(200)
      end
    end

    context 'when param is valid' do
      let(:not_avaliable_user_id) { 0 }
      it 'returns none 200 status and returns error messages' do
        post "/users/#{current_user.id}/touch_relationship/#{not_avaliable_user_id}"

        expect(response.status).not_to eq(200)
        expect(json_response['error']).to be_present
      end
    end
  end

  describe 'GET /followees_sleep_records' do
    include_context 'when_current_user_is_following_other_users'
    let(:unfollowed_user) { create(:user) }
    let!(:sleep_record_1) { create(:sleep_record, user: other_user_1) }
    let!(:sleep_record_2) { create(:sleep_record, user: other_user_1) }
    let!(:sleep_record_3) { create(:sleep_record, user: other_user_2) }
    let!(:sleep_record_4) { create(:sleep_record, user: other_user_2, created_at: 10.days.ago) }
    let!(:sleep_record_5) { create(:sleep_record, user: unfollowed_user) }

    it 'returns 200 status' do
      get "/users/#{current_user.id}/followees_sleep_records"

      expect(response.status).to eq(200)
    end

    it 'return the sleep_records of other users in the order of duration' do
      get "/users/#{current_user.id}/followees_sleep_records"

      expected_order = SleepRecord.where(id: [sleep_record_1.id, sleep_record_2.id, sleep_record_3.id]).order(duration: :desc).pluck(:id)

      expect(json_response['sleep_records'].size).to eq(3)
      expect(json_response['sleep_records'].pluck('id')).to eq(expected_order)
    end
  end
end
