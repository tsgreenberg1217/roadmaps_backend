class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :stop_id, :activity_pictures
  has_many :pictures
end
