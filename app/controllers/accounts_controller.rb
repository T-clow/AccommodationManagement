class AccountsController < ApplicationController
  def show
    @user = current_user

    # パラメータによってビューの描画先を変更
    case params[:page]
    when 'account'
      render 'users/account'
    when 'profile'
      render 'users/profile'
    else
      # デフォルトはアカウントページ
      render 'users/account'
    end
  end
end
