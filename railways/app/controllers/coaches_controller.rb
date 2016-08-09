class CoachesController < ApplicationController
  before_action :set_coach, only: [:show, :edit, :update, :destroy]

  def index
    @coaches = Coach.all
  end

  def show
  end

  def new
    @coach = Coach.new
    @just_seats = @coach.just_seats
  end

  def edit
    @just_seats = @coach.just_seats
  end

  def create
    @coach = coach_params[:type].constantize.new(coach_params)

    if @coach.save 
      redirect_to(coach_url(@coach.becomes(Coach)), notice: 'Coach was successfully created.') 
    else
      @just_seats = @coach.just_seats
      render(:new)
    end
  end

  def update
    @coach = coach_params[:type].constantize.find(params[:id])

    if @coach.update(coach_params) 
      redirect_to(coach_url(@coach.becomes(Coach)), notice: 'Coach was successfully updated.') 
    else 
      @just_seats = @coach.just_seats
      render(:edit)
    end
  end

  def destroy
    @coach.destroy
    redirect_to coaches_url, notice: 'Coach was successfully destroyed.'
  end

  private
    def set_coach
      @coach = Coach.find(params[:id])
    end

    def coach_params
      params.require(:coach).permit(:type, :train_id, :top_seats, :bottom_seats, :side_top_seats, :side_bottom_seats, :simple_seats)
    end
end
