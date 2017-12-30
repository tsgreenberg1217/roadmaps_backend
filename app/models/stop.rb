class Stop < ApplicationRecord
  belongs_to :trip
  has_many :activities


  def stop_activities
    self.activities.all
  end
end
