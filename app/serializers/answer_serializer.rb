class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :titleized_title, :body
end
