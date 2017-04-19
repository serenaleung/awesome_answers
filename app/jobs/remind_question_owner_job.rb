class RemindQuestionOwnerJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    question_id = args[0]
    question = Question.find question_id
    if question.answers.count == 0
      #TODO: email question owner
      puts ">>>>>>>>>>> NO ANSWERS FOR THIS QUESTION"
    end
  end
end
