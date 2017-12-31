class Activity < ApplicationRecord
  belongs_to :stop
  has_many :pictures

  def activity_pictures
    self.pictures.all
  end

end
