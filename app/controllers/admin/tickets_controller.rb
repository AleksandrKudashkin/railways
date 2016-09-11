class Admin::TicketsController < Admin::BaseController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  before_action :set_train, only: [:index, :new, :create]
  before_action :set_list, only: [:new, :edit, :create, :update]

  def index
    @tickets = Ticket.all
  end

  def show
  end

  def edit
  end

  def update
    if @ticket.update(ticket_params)
      redirect_to([:admin, @ticket], notice: 'Ticket was successfully updated.')
    else
      render(:edit)
    end
  end

  def destroy
    @train = @ticket.train
    @ticket.destroy
    redirect_to [:admin, @train, :tickets], notice: 'Ticket was successfully destroyed.'
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
