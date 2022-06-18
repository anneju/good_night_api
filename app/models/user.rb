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

  has_many :followed_users, foreign_key: :follower_id, class_name: 'Relationship', dependent: :destroy
  has_many :followees, through: :followed_users, dependent: :destroy

  has_many :following_users, foreign_key: :followee_id, class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :following_users, dependent: :destroy

  def lastest_clock_in
    clock_ins.order(created_at: :desc).first
  end
end
