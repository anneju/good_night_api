require 'rails_helper'

RSpec.describe 'ClockIns', type: :request do
  let(:user) { create(:user) }

  describe 'GET /index' do
    let!(:clock_in_1) { create(:clock_in, user: user, created_at: Time.current) }
    let!(:clock_in_2) { create(:clock_in, user: user, created_at: Time.current + 10) }
    let!(:clock_in_3) { create(:clock_in, user: user, created_at: Time.current + 20) }

    before { get "/users/#{user.id}/clock_ins" }

    it 'returns 200 status and clock_ins records' do
      expect(response.status).to eq(200)
      expect(json_response['clock_ins'].size).to eq(3)
    end

    it 'return clock_ins records by created_at desc order' do
      expect(json_response['clock_ins'].pluck('id')).to eq([clock_in_3.id, clock_in_2.id, clock_in_1.id])
    end
  end
end
