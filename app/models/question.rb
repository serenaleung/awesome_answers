# this is our Question model it inhertis from `ApplicationRecord` which inherits
# from `ActiveRecord::Base` which is a class that comes from Rails.
# All the funcationalities we're going to be using in our Quesiton model come
# from `ActiveRecord::Base` which leverages Ruby's meta programming features.
class Question < ApplicationRecord
  has_many :answers
  # as of Rails 5, belongs_to :subject will enforce a validation
  # that the association must be present by default
  # to make it optional, gibe belongs_to a second argument `optional: true`
  belongs_to :subject, optional: true
  # supposed to be answers but typo

  # has_many :answers adds the following instance methods
  # to this model, Question:
  # answers
  # answers<<(object, ...)
  # answers.delete(object, ...)
  # answers.destroy(object, ...)
  # answers=(objects)
  # answers
  # answers=(ids)
  # answers.clear
  # answers.empty?
  # answers.size
  # answers.find(...)
  # answers.where(...)
  # answers.exists?(...)
  # answers.build(attributes = {}, ...)
  # answers.create(attributes = {})
  # answers.create!(attributes = {})
  # http://guides.rubyonrails.org/association_basics.html#has-many-association-reference


  validates(:title, { presence: { message: 'must be present!' },
                      uniqueness: true })
  validates(:body,{ presence: true, length: { minimum: 5 } })
  validates(:view_count, { presence: true,
                           numericality: { greater_than_or_equal_to: 0 }})

  # this is used for custom-validation method, we expect to have a method called
  # `no_monkey` defined, ideally in the private section of the class
  validate :no_monkey

  after_initialize :set_defaults
  before_validation :titleize_title

  private

  def titleize_title
     self.title = title.titleize if title.present?
   end

  #  scope :recent_five, lambda { order(created_at: :desc).limit(5) }
  def self.recent_five
    order(created_at: :desc).limit(5)
  end

  def self.recent(number)
    order(created_at: :desc).limit(number)
  end

   # set default count to 0
  def set_defaults
    self.view_count ||= 0
  end


# if there is monkey in the title it will return can't include monkey
  def no_monkey
    if title.present? && title.downcase.include?('monkey')
      # this will make the record invalid, even if there is one error on the
      # record by using `errors.add` then the record won't save because it won't
      # be valid
      errors.add(:title, 'can\'t include monkey!')
    end
  end

end
