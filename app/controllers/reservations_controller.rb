class ReservationsController < ApplicationController

  def new
    if params[:room_id].present?
      @room = Room.find(params[:room_id]) 
      @reservation = @room.reservations.build
    else
      flash[:error] = "Invalid room ID"
      redirect_to root_path
    end
  end
  
  def confirm
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(confirmed_at: Time.now)
      redirect_to reservation_path(@reservation)
    else
      render :confirm
    end
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to confirm_reservation_path(@reservation)
    else
      render :new
    end
  end
  
  private
  
  def reservation_params
    params.require(:reservation).permit(:room_id, :user_id, :start_date, :end_date, :number_of_people)
  end
  
end
