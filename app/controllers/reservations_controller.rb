class ReservationsController < ApplicationController

  def index
    @reservations = current_user.reservations #ログイン中のユーザーの予約のみ表示
  end

  def new
    @room = Room.find(params[:room_id]) if params[:room_id].present?
    @reservation = @room.reservations.build
  end

  
  def confirm
    @reservation = Reservation.new(reservation_params)
    @room = @reservation.room
  end

  def update_confirmation
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
    @reservation.confirmed_at = Time.current

    # 確定処理を実行
    if @reservation.update(is_confirmed: true)
      redirect_to reservation_path(@reservation), notice: '予約が確定しました。'
    else
      render :confirm
    end
  end
  

  

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.confirmed_at = Time.current

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
    @room = @reservation.room
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservation_url, notice: '施設を削除しました'
  end


  
  private
  
  def reservation_params
    params.require(:reservation).permit(:room_id, :user_id, :start_date, :end_date, :number_of_people)
  end
  
end