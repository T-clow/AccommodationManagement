class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :user
  attr_accessor :price
  

  def stay_duration
    (end_date - start_date).to_i / 1.day.to_i #1日の秒数で割る
  end

  def total_price
    room&.price.to_i * number_of_people.to_i * stay_duration.to_i
  end
end
