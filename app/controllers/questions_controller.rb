class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  # the `before_action` method registers another method in this case it's the
  # `find_quesiton` method which will be executed just before the actions you
  # specify in the `only` array. Keep in mind that the method that gets executed
  # as a `before_action` happens within the same request/response cycle so if
  # you define an instance variable you can use it within the action / views
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  def new
    # we instaniate a new `Question` object because it will help us in
    # generating the form in `views/new.html.erb`. We have to make it an
    # instance variable so we can access it in the view file.
    @question = Question.new
  end

    # the following is what is in params

    # {
    #   "utf8": "â",
    #   "authenticity_token": "k11lTUVFT+txNLXwLzqD3vZEd1dluudvc",
    #   "question": {
    #     "title": "abc",
    #     "body": "xyz"
    #   },
    #   "commit": "Create Question",
    #   "controller": "questions",
    #   "action": "create"
    # }

  def create
     # the line below is what's called "Strong Parameters" feautre that was added
     # to Rails starting with version 4 to help developer be more explicit about
     # the parameters that they want to allow the user to submit
    question_params = params.require(:question).permit([:title, :body, :image])
    @question = Question.new question_params
    @question.user = current_user

    if @question.save
      RemindQuestionOwnerJob.set(wait: 5.days).perform_later(@question.id)
      # redirct_to question_path({id: @question.id})
      # redirect_to question_path(@question.id)

      #
      # render :show
      # render plain: 'Question created successfully'

      flash[:notice] = 'Question created!'
      redirect_to question_path(@question)

    else
      # because you're in the same path already
      # render 'questions/new'


      # if you want to show a flash message when you're doing `render`instead
      # of `redirect` meaning that you want to show the flash message within the
      # same requestion/response cycle, then you will need to use flash.now
      flash.now[:alert] = 'Please fix errors below'
      render :new


      # render plain: "Errors: #{question.errors.full_messages.join(', ')}"
    end
    # render json: params
  end

  def show
    @answer = Answer.new

    # render 'questions/show'
    # `respond_to` method allows us to render different outcomes depending on
    # the format of the requests. Remember that the default format for any
    # request in Rails applciations is HTML.

    respond_to do |format|
      # this 👇  means that if the format of the request is HTML then we will
      # render the `show` template (questiosn/show.html.erb)
      format.html { render :show }
      # this ð will render `json` if the format of the request is JSON.
     # ActiveRecord has a built-in feature to generate JSON from any object of
     # ActiveRecord.
      format.json { render json: @question }
    end

    # {"controller":"questions","action":"show","id":"4"}
    # if you take json out it'll render app/views/questions/show.html.erb

    # @question = Question.find params[:id]

    # render json: params
  end

  def index
    @questions = Question.last(20)
  end

  def edit
    # can? is a helper method that came from CanCanCan which helps us enforce
    # permission rules in the controllers and views

    redirect_to root_path, alert: 'access denied' unless can? :edit, @question
    # @question = Question.find params[:id]
    # render plain: 'inside questions edit'
  end

  def update
    # @question = Question.find params[:id]
    # find the new question to update it
    # get the params to make sure you're updating the right post

    # question_params = params.require(:question).permit([:title, :body])

    # update it
    # if succeeds redirect to the show page
    if !(can? :edit, @question)
      redirect_to root_path, alert: 'access denied'
    elsif @question.update(question_params.merge({ slug: nil }))
      redirect_to question_path(@question), notice: 'Question updated'
    else
    # if doesn't show the edit page
      render :edit
    # render plain: 'Questions update'
    end
  end

  def destroy
    # question = Question.find params[:id]
    # question.destroy

    # local variable because only redirecting
    # only need instance variables if sharing with a template
    if can? :destroy, @question
      @question.destroy
      redirect_to questions_path, notice: 'Question deleted'
    else
      redirect_to root_path, alert: 'access denied'
    end
    # render plain: 'in questions destroy'
  end

  def find_question
    @question = Question.find params[:id]
  end

  def question_params
     # the line below is what's called "Strong Parameters" feautre that was added
     # to Rails starting with version 4 to help developer be more explicit about
     # the parameters that they want to allow the user to submit
     params.require(:question).permit([:title, :body, {tag_ids: [] }, :image ])
  end

end
