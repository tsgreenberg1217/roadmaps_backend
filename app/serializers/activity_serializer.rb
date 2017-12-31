class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :stop_id
  has_many :pictures
end
