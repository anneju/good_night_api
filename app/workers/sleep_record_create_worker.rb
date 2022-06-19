class SleepRecordCreateWorker
  include Sidekiq::Worker
  sidekiq_options retry: true

  def perform(wake_up_clock_in_id)
    wake_up_clock_in = ClockIn.find(wake_up_clock_in_id)
    user_id = wake_up_clock_in.user_id
    last_sleep_clock_in = ClockIn.sleep.where(user_id: user_id).where("created_at < ?", wake_up_clock_in.created_at).order(created_at: :desc).first

    SleepRecord.create(user_id: user_id, wake_up_clock_in: wake_up_clock_in, sleep_clock_in: last_sleep_clock_in)
  end
end
