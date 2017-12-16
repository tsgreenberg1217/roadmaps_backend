class Friendship < ApplicationRecord
  belongs_to :trip
  belongs_to :friend, class_name: 'User'
end
