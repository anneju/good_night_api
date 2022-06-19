require 'rails_helper'

RSpec.describe SleepRecordCreateWorker do
  subject(:worker) { described_class.new }

  let(:user) { create(:user) }
  let!(:sleep_clock_in) { create(:clock_in, :sleep, user: user, created_at: Faker::Time.between(from: 1.days.ago, to: 10.minutes.ago)) }
  let!(:wake_up_clock_in) { create(:clock_in, :wake_up, user: user, created_at: Time.now) }

  describe '#perform' do
    it 'should create a sleep record with correct data' do
      expect { worker.perform(wake_up_clock_in.id) }.to change { SleepRecord.count }.by(1)
      sr = SleepRecord.first
      expect(sr.sleep_clock_in_id).to eq(sleep_clock_in.id)
      expect(sr.wake_up_clock_in_id).to eq(wake_up_clock_in.id)

      time_diff = (wake_up_clock_in.created_at - sleep_clock_in.created_at)
      expect(sr.duration).to eq(time_diff.to_i)
    end
  end
end
