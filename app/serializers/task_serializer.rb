class TaskSerializer < ActiveModel::Serializer
  attributes :id, :deadline, :name, :done, :status
end
