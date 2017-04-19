class AnswersMailer < ApplicationMailer
  def notify_question_owner(answer)
    # you can share instance varaibales with templates the same way we do with
    # rails controllers
    @answer = answer
    @question = answer.question
    @user = @question.user #.user because in question.rb you wrote question belongs to user

    # this will render app/views/answers_mailer/notify_question_owner.html.erb
    # and/or app/views/answers_mailer/notify_question_owner.text.erb
    mail(to: 'serenaleung1@gmail.com', subject: 'Test email')
    # mail(to: '@user.email', subject: 'You got an answer!') if @user
  end
end
