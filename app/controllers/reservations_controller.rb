class ReservationsController < ApplicationController
    before_action :set_room, only: [:new, :create]
  
    def new
        @room = Room.find(params[:room_id])
    end
  
    def create
      @reservation = @room.reservations.new(reservation_params)
  
      if @reservation.save
        redirect_to @room, notice: 'Reservation was successfully created.'
      else
        render :new
      end
    end
  
    private
  
    def set_room
      @room = Room.find(params[:room_id])
    end
  
    def reservation_params
      params.require(:reservation).permit(:start_date, :end_date, :number_of_people)
    end
  end
  