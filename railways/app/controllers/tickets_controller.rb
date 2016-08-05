class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def index
    @tickets = Ticket.all
  end

  def show
  end

  def new
    @ticket = Ticket.new
  end

  def edit
  end

  def create
    @ticket = Ticket.new(ticket_params)
    @ticket.save ? redirect_to(@ticket, notice: 'Ticket was successfully created.') : render(:new)
  end

  def update
    @ticket.update(ticket_params) ? redirect_to(@ticket, notice: 'Ticket was successfully updated.') : render(:edit)
  end

  def destroy
    @ticket.destroy
    redirect_to tickets_url, notice: 'Ticket was successfully destroyed.'
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def ticket_params
      params.require(:ticket).permit(:train_id, :first_station_id, :last_station_id, :passenger_full_name)
    end
end
