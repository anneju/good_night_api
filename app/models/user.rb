# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :name, presence: true

  has_many :clock_ins, dependent: :destroy

  def lastest_clock_in
    clock_ins.order(created_at: :desc).first
  end
end
