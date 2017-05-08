class Api::V1::QuestionsController < Api::BaseController
  before_action :authenticate_user
  def index
    @questions = Question.all.order('created_at DESC')
  end

  def show
    @question = Question.find params[:id]
    # render json: question.to_json

    # if the format is JSON and we're using jbuilder as our templating system
    # what file will be rendered?
    # /views/api/v1/questions/show.json.jbuilder


    #using `render :show` or no render at all will use the correspoding view
    # for the specified format (eg. jbuilder for json)
    # render json: @question

  end

  def create
    question_params = params.require(:question).permit(:title, :body)
    # {questionLL {title: 'abd'. body: 'sdfsd'}}
    question = Question.new question_params
    question.user = @user

    if question.save
      head :ok
    else
      render json: {error: question.errors.full_messages.join(', ')}
    end

  end

end
