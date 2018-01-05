class PicturesSerializer < ActiveModel::Serializer
  attributes :id, :url, :desc, :activity_id
end
