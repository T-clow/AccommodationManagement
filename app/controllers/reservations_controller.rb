class ReservationsController < ApplicationController


  def index
    @reservations = Reservation.all
  end
  
  def new
    @room = Room.find(params[:room_id]) if params[:room_id].present?
    @reservation = @room.reservations.build if @room.present?
    @reservation ||= Reservation.new
  end
    
  def confirm
    @reservation = Reservation.find(params[:id])
    puts "@reservation: #{@reservation.inspect}"
    @room = @reservation.room
  end

  def update_confirmation
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room

    # 確定処理を実行
    if @reservation.update(is_confirmed: true)
      redirect_to reservation_path(@reservation), notice: '予約が確定しました。'
    else
      render :confirm
    end
  end

  

  def create
    @reservation = Reservation.find(reservation_params)

    if @reservation.save
      # 予約作成に成功したら、詳細ページにリダイレクト
      redirect_to reservation_path(@reservation)
    else
      # 予約作成に失敗したら、予約作成画面に戻る
      render :new
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  
  private
  
  def reservation_params
    params.require(:reservation).permit(:room_id, :user_id, :start_date, :end_date, :number_of_people)
  end
  
end
