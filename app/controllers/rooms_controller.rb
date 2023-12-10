class RoomsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
  
    def index
      @rooms = current_user.rooms #ログイン中のユーザーの登録施設のみ表示
    end
  
    def show
      @room = Room.find(params[:id])
      @reservation = Reservation.new
    end
  
    def new
      @room = Room.new
    end
  
    def create
        @room = current_user.rooms.build(room_params)
    
        if @room.save
          redirect_to @room, notice: '施設を登録しました'
        else
          flash.now[:alert] = '施設の登録に失敗しました'
          render :new
        end
      end
      
  
    def edit
      @room = Room.find(params[:id])
    end
  
    def update
      @room = Room.find(params[:id])
      if @room.update(room_params)
        redirect_to @room, notice: '施設を更新しました.'
      else
        render :edit
      end
    end
  
    def destroy
      @room = Room.find(params[:id])
      @room.destroy
      redirect_to rooms_url, notice: '施設を削除しました'
    end

    def search
      @results = Room.search_by_address(params[:address_query]).search_by_name_or_description(params[:free_query])
    end

    private
  
    def room_params
      params.require(:room).permit(:name, :description, :price, :address, :image)
    end
  end
  