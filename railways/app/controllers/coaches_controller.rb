class CoachesController < ApplicationController
  before_action :set_type
  before_action :set_train, only: [:index, :new, :create]
  before_action :set_coach, only: [:show, :edit, :update, :destroy]
  before_action :set_restricted_list, only: [:edit, :update]

  def index
    @coaches = type_class.all
  end

  def show
  end

  def new
    @coach = type_class.new
    set_list
  end

  def edit
    set_restricted_list
  end

  def create
    @type = params[:coach] ? params[:coach][:type] : params[:type] 
    @coach = @type.constantize.new(coach_params)
    
    if @coach.save 
      redirect_to @coach, notice: 'Coach was successfully created.'
    else
      set_restricted_list
      render(:new)
    end
  end

  def update
    if @coach.update(coach_params) 
      redirect_to @coach, notice: 'Coach was successfully updated.'
    else 
      set_restricted_list
      render(:edit)
    end
  end
  
  def destroy
    @train = @coach.train
    @coach.destroy
    redirect_to train_coaches_url(@train), notice: 'Coach was successfully destroyed.'
  end

  private
    def set_train
      @train = Train.find(params[:train_id])
    end

    def set_type
      @type = type 
    end
 
    def type
      Coach.types.include?(params[:type]) ? params[:type] : "Coach"
    end
     
    def type_class 
      type.constantize 
    end

    def set_coach
      @coach = type_class.find(params[:id])
    end

    def set_list
      @seats_list = @coach.seats_list
    end

    def set_restricted_list
      @seats_list = @coach.allowed_list
    end

    def coach_params
      params.require(type.underscore.to_sym).permit(
        :type, :train_id, :top_seats, :bottom_seats, :side_top_seats, :side_bottom_seats, :simple_seats
      )
    end
end
