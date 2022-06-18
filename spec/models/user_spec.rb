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
end
