class TicketsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :set_train, only: [:new, :create]
  before_action :set_list, only: [:new, :edit, :create, :update]

  def index
    @tickets = current_user.tickets.all
  end

  def show
  end

  def new
    @stations = RailwayStation.all
    @ticket = Ticket.new
    @ticket.train_id = params[:train_id]
    @ticket.first_station_id = params[:station_depart]
    @ticket.last_station_id = params[:station_arrive]
  end

  def edit
  end

  def create
    @ticket = current_user.tickets.new(ticket_params)
    @ticket.save ? redirect_to(@ticket, notice: 'Ticket was successfully created.') : render(:new)
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to(@ticket, notice: 'Ticket was successfully updated.')
    else
      render(:edit)
    end
  end

  def destroy
    @train = @ticket.train
    @ticket.destroy
    redirect_to train_tickets_url(@train), notice: 'Ticket was successfully destroyed.'
  end

  private

  def set_list
    @stations = RailwayStation.joins(routes: :trains).where('trains.id = ?', 7)
  end

  def set_train
    @train = Train.find(params[:train_id])
  end

  def set_ticket
    @ticket = Ticket.find(params[:id])
  end

  def ticket_params
    params.require(:ticket).permit(
      :train_id,
      :first_station_id,
      :last_station_id,
      :passenger_full_name,
      :passport
    )
  end
end
