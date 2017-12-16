class Trip < ApplicationRecord
  belongs_to :user
  has_many :friendships
  has_many :friends, through: :friendships

end
