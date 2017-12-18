class Trip < ApplicationRecord
  belongs_to :user
  has_many :friendships
  has_many :friends, through: :friendships

  has_many :stops
  has_many :activities, through: :stops

end
