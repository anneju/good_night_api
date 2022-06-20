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
#  index_clock_ins_on_user_id                 (user_id)
#  index_clock_ins_on_user_id_and_created_at  (user_id,created_at)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe ClockIn, type: :model do
  let(:user) { create(:user) }
  context 'when user has no clock_in records' do
    it 'create a sleep clock_in record' do
      clock_in = user.clock_ins.create

      expect(clock_in.category).to eq('sleep')
    end
  end

  context 'when user has clock_in records' do
    before { create(:clock_in, :sleep, user: user) }

    context 'previous clock_in record is a sleep record' do
      it 'create a wake_up clock_in record' do
        clock_in_new = user.clock_ins.create

        expect(clock_in_new.category).to eq('wake_up')
      end
    end

    context 'previous clock_in record is a wake_up record' do
      before { create(:clock_in, :wake_up, user: user) }

      it 'create a sleep clock_in record' do
        clock_in_new = user.clock_ins.create

        expect(clock_in_new.category).to eq('sleep')
      end
    end
  end

  context 'user create a wake_up clock_in' do
    before { create(:clock_in, :sleep, user: user) }
    it 'should call SleepRecordCreateWorker' do
      expect(SleepRecordCreateWorker).to receive(:perform_async).once
      user.clock_ins.create
    end
  end
end
