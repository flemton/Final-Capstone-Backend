class Api::ReservationsController < ApplicationController
  before_action :set_tesla_model, only: [:create]
  before_action :set_reservation, only: %i[show update destroy]

  def user_reservations
    @reservations = current_user.reservations
    response = @reservations.map(&:reservation_with_tesla_model)
    render json: response
  end

  def index
    @reservations = current_user.reservations
    render json: @reservations
  end

  def show
    render json: @reservation
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = current_user
    @reservation.tesla_model = @tesla_model

    if @tesla_model.available?(@reservation.start_time, @reservation.end_time)
      if @reservation.save
        render json: { success: true, reservation_id: @reservation.id }
      else
        render json: { error: @reservation.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { error: 'TeslaModel is not available for reservation' }, status: :unprocessable_entity
    end
  end

  def update; end

  def destroy; end

  private

  def set_tesla_model
    @tesla_model = TeslaModel.find(params[:tesla_model_id])
  end

  def reservation_params
    params.require(:reservation).permit(:start_time, :end_time, :city)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end
