# == Schema Information
#
# Table name: clock_ins
#
#  id         :bigint           not null, primary key
#  category   :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_clock_ins_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe ClockIn, type: :model do
  context "when category is neither sleep nor wake_up" do
    let(:clock_in) { build(:clock_in, category: 'others') }

    it "returns false and error messages" do
      expect(clock_in.save).to be_falsy
      expect(clock_in.errors.messages[:category]).to include('others is not a valid category')
    end
  end
end
