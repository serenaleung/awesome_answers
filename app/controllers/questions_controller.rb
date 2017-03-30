class QuestionsController < ApplicationController
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
    question_params = params.require(:question).permit([:title, :body])
    @question = Question.new question_params
    if @question.save
      # redirct_to question_path({id: @question.id})
      # redirect_to question_path(@question.id)
      redirect_to question_path(@question)
      #
      # render :show
      # render plain: 'Question created successfully'
    else
      # because you're in the same path already
      render :new
      # render 'questions/new'
      # render plain: "Errors: #{question.errors.full_messages.join(', ')}"
    end
    # render json: params
  end

  def show
    # {"controller":"questions","action":"show","id":"4"}
    # if you take json out it'll render app/views/questions/show.html.erb
    @question = Question.find params[:id]
    # render json: params
  end

  def index
    @questions = Question.last(20)
  end

  def edit
    @question = Question.find params[:id]
    # render plain: 'inside questions edit'
  end

  def update
    @question = Question.find params[:id]
    # find the new question to update it
    # get the params to make sure you're updating the right post
    question_params = params.require(:question).permit([:title, :body])
    # update it
    # if succeeds redirect to the show page
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
    # if doesn't show the edit page
      render :edit
    # render plain: 'Questions update'
    end
  end

  def destroy
    question = Question.find params[:id]
    question.destroy
    redirect_to questions_path
    # render plain: 'in questions destroy'
  end


end
