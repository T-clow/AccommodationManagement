class ReservationsController < ApplicationController

  def index
    @reservations = current_user.reservations #ログイン中のユーザーの予約のみ表示
  end

  def new
    @room = Room.find(params[:room_id]) if params[:room_id].present?
    @reservation = current_user.reservations.find_or_initialize_by(room: @room)
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @room = @reservation.room
    unless @reservation.valid?
      @reservation.errors.add(:base, "入力内容にエラーがあります。修正してください。")
      render 'rooms/show'
    end
  end

  def create
    @reservation = current_user.reservations.find_or_initialize_by(id: params[:id])
    @reservation.assign_attributes(reservation_params)
    @reservation.confirmed_at = Time.current

    if @reservation.save
      redirect_to reservation_path(@reservation), notice: '予約が確定しました。'
    else
      redirect_to room_path(id: params[:reservation][:room_id]), alert: '予約に失敗しました。'
    end
  end

  def show
    @reservation = Reservation.find_by(id: params[:id])

    if @reservation
      @room = @reservation.room
    else
      # レコードが見つからない場合の処理
      redirect_to root_path, alert: 'Reservation not found'
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @room = @reservation.room
  end

  def update
    @reservation = Reservation.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to reservation_path(@reservation), notice: '予約を更新しました.'
    else
      render :edit
    end
  end

 def update_confirm
  @reservation = Reservation.find(params[:id])

  # フォームが送信されたデータを使って予約を更新
  if @reservation.update(reservation_params)
    # 更新に成功した場合の処理
    @room = @reservation.room
  else
    # 更新に失敗した場合の処理
    render :edit
  end
end


  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, notice: '施設を削除しました'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:room_id, :user_id, :start_date, :end_date, :number_of_people, :price)
  end

end
