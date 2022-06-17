require 'rails_helper'

RSpec.describe "ClockIns", type: :request do
  let(:user) { create(:user) }

  describe "GET /index" do
    let!(:clock_in_1) { create(:clock_in, user: user, created_at: Time.current) }
    let!(:clock_in_2) { create(:clock_in, user: user, created_at: Time.current + 10) }
    let!(:clock_in_3) { create(:clock_in, user: user, created_at: Time.current + 20) }

    it "returns 200 status and clock_ins records" do
      get "/users/#{user.id}/clock_ins"

      expect(response.status).to eq(200)
    end
  end
end
