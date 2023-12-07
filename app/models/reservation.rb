class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :user
  attr_accessor :price


  def update_confirmation_check
    # ここに適切な確認処理を実装する
    # 確認が成功した場合は true を、失敗した場合は false を返す
    # 例: 簡単な確認処理として、number_of_people が 5 以下であれば確認成功とする
    number_of_people.to_i <= 5
  end
  

  def stay_duration
    (end_date - start_date).to_i / 1.day.to_i #1日の秒数で割る
  end

  def total_price
    room&.price.to_i * number_of_people.to_i * stay_duration.to_i
  end
end
