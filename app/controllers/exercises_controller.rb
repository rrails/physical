class ExercisesController < ApplicationController
  before_filter :only_authorised

  def index
    @exercises = @auth.exercises.order(:activity).order(:completed)
    @activities = @auth.exercises.map(&:activity).uniq.sort
  end

  def new
    @exercise = Exercise.new
  end

  def create
    exercise = Exercise.create(params[:exercise])
    @auth.exercises << exercise
    @exercises = @auth.exercises.order(:activity).order(:completed)
    @activities = @auth.exercises.map(&:activity).uniq.sort
  end

  def chart
    render :json => @auth.exercises.where(:activity => params[:activity])
  end
  private
  def only_authorised
    redirect_to(root_path) if @auth.nil?
  end
end
