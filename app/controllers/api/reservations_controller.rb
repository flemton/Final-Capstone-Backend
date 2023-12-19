class Api::ReservationsController < ApplicationController
  before_action :set_tesla_model, only: [:create]
  before_action :set_reservation, only: %i[show update destroy]

  def user_reservations
    @reservations = @current_user.reservations
    response = @reservations.map(&:reservation_with_tesla_model)
    render json: response
  end

  def index
    @reservations = @current_user.reservations
    render json: @reservations
  end

  def show
    render json: @reservation
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user = User.find(params[:user_id])
    puts 'User: ', @reservation.user
    @reservation.tesla_model = @tesla_model

    if @tesla_model.available?(@reservation.start_date, @reservation.end_date)
      if @reservation.save
        render json: { success: true, reservation_id: @reservation.id }
      else
        render json: { error: 'Error saving reservation', details: @reservation.errors.full_messages },
               status: :unprocessable_entity
      end
    else
      render json: { error: 'TeslaModel is not available for reservation', details: @tesla_model.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @reservation.update(reservation_params)
      render json: { success: true, reservation: @reservation }
    else
      render json: { error: 'TeslaModel is not available for reservation', details: @tesla_model.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @reservation.destroy
    render json: { success: true, message: 'Reservation was successfully deleted.' }
  end

  private

  def set_tesla_model
    @tesla_model = TeslaModel.find(params[:tesla_model_id])
    return if @tesla_model

    logger.error("TeslaModel with id #{params[:tesla_model_id]} not found")
  end

  def reservation_params
    params.require(:reservation).permit(:user_id, :start_date, :end_date, :city)
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end
