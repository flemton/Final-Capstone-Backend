class Api::ReservationsController < ApplicationController
  before_action :set_tesla_model, only: [:create]
  before_action :set_reservation, only: %i[show update destroy]
  def index
    @reservations = current_user.reservations
    render json: @reservations
  end

  def show
    render json: @reservation
  end

  def create; end

  def update; end

  def destroy; end

  private

  def set_tesla_model
    @tesla_model = TeslaModel.find(params[:tesla_model_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end
end
