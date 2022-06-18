require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:current_user) { create(:user) }
  let(:target_user) { create(:user) }

  describe 'POST /touch_relationship' do
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
        expect(json_response['errors']).to be_present
      end
    end
  end
end
