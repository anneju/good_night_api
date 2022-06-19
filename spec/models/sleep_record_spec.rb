# == Schema Information
#
# Table name: sleep_records
#
#  id                  :bigint           not null, primary key
#  duration            :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  sleep_clock_in_id   :bigint
#  user_id             :bigint           not null
#  wake_up_clock_in_id :bigint
#
# Indexes
#
#  index_sleep_records_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe SleepRecord, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
