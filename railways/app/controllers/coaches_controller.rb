class CoachesController < ApplicationController
  before_action :set_coach, only: [:show, :edit, :update, :destroy]

  def index
    @coaches = Coach.all
  end

  def show
  end

  def new
    @coach = Coach.new
  end

  def edit
  end

  def create
    @coach = Coach.new(coach_params)
    @coach.save ? redirect_to(coach_url(@coach), notice: 'Coach was successfully created.') : render(:new)
  end

  def update
    @coach.update(coach_params) ? redirect_to(coach_url(@coach), notice: 'Coach was successfully updated.') : render(:edit)
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
      params.require(:coach).permit(:type, :train_id, :top_seats, :bottom_seats)
    end
end
