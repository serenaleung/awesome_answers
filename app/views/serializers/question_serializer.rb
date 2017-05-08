class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :titleized_title, :body

  def titleized_title
    object.title.upcase
  end
end
