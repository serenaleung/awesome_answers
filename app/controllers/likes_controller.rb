class LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:user_id])
    @questions = user.liked_questions

    render 'questions/index'
  end

  def create
    @question = Question.find(params[:question_id])

    if cannot? :like, @question
      redirect_to(
        question_path(@question),
        alert: 'Liking your own question is disgusting ð¤¢'
      )
      return # early return to prevent execution of anything
      # after the redirect above
    end

    like = Like.new(user: current_user, question: @question)

    respond_to do |format|
      if like.save
        format.html { redirect_to question_path(@question), notice: 'Liked question! ð' }
        format.js   { render :render_like }
      else
        format.html { redirect_to question_path(@question), alert: like.errors.full_messages.join(', ') }
        format.js   { render :render_like }
      end
    end
  end

  def destroy
    like = Like.find(params[:id])
    @question = Question.find params[:question_id]
    if cannot? :like, @question
      redirect_to(
        question_path(@question),
        alert: 'Un-liking your own question is prepostrous ð¤¢'
      )
      return # early return to prevent execution of anything
      # after the redirect above
    end

    respond_to do |format|
      if like.destroy
        format.html {redirect_to question_path(@question), notice: 'Un-liked question! ð'}
        format.js   {render :render_like}
      else
        format.html {redirect_to question_path(@question), alert: like.errors.full_messages.join(', ')}
        format.js   {render :render_like}
      end
    end
  end
end
