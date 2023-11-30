class ReservationsController < ApplicationController
  before_action :set_room, only: [:new, :create, :confirm]

  def index
    @reservation = Reservation.all
  end

  def new
    @reservation = Reservation.new
  end

  def confirm
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room

    if @reservation.invalid?
      render 'new'
    end
  end

  def confirm_update
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room

    if @reservation.update(reservation_params)
      redirect_to reservation_path(@room, @reservation), notice: '予約が更新されました。'
    else
      render 'confirm'
    end
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new(reservation_params)
    @reservation.room = @room
    @reservation.user = current_user

    if @reservation.save
      redirect_to confirm_room_reservation_path(@room, @reservation), notice: '予約が完了しました。'
    else
      render 'new'
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

def reservation_params
  params.require(:reservation).permit(:room_id, :start_date, :end_date, :number_of_people, :user_id, :price)
end

  
end
