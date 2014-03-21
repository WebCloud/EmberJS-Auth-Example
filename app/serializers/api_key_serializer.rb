class ApiKeySerializer < ActiveModel::Serializer
  attributes :id, :user_id, :access_token, :scope, :expired_at, :created_at
end
