class LessonsController < ApplicationController
  before_action :logged_in_user
  before_action :find_lesson, only: [:show, :update]

  def new 
    @lesson = Lesson.new
  end

  def create
    @lesson = Lesson.new lesson_params
    if @lesson.save
      flash[:success] = t "lesson.created"
      redirect_to current_user
    else
      render :new
    end
  end

  def show
    if @lesson.start?
      wordId = Word.getListWord @lesson.category_id, @lesson.question_count
      @lesson.addResults wordId
      @lesson.updateDeadline
      @lesson.testing!
    elsif @lesson.testing? && @lesson.timeout?
      @lesson.finish!
      @lesson.updateScore
    end   
  end

  def update
    unless @lesson.finish?
      @lesson.finish!
      @lesson.update_attributes lesson_params
      @lesson.updateScore
      redirect_to current_user
    end
  end

  private
  def find_lesson
    @lesson = Lesson.find_by id: params[:id]
    if @lesson.nil?
      flash.now[:danger] = t :error
      redirect_to @lesson.user
    end
  end

  def lesson_params
    params.require(:lesson).permit :user_id, :category_id, :level_id,
     :duration, :question_count, results_attributes: [:id, :answer_id, :is_correct]
  end
end
