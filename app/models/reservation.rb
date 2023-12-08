class Reservation < ApplicationRecord
  belongs_to :room
  belongs_to :user
  attr_accessor :price

  validate :start_date_should_be_in_present_or_future
  validate :end_date_should_be_after_start_date
  validates :number_of_people, numericality: { greater_than_or_equal_to: 1, message: "は1人以上を入力してください" }

  def start_date_should_be_in_present_or_future
    if start_date.present? && start_date < Date.current.beginning_of_day
      errors.add(:start_date, "は本日以降の日付を選択してください")
    end
  end

  def end_date_should_be_after_start_date
    return unless start_date.present? && end_date.present?
    
    if end_date <= start_date
      errors.add(:end_date, "は開始日よりも後の日付にしてください")
    end
  end

 
  def stay_duration
    (end_date - start_date).to_i / 1.day.to_i #1日の秒数で割る
  end

  def total_price
    room&.price.to_i * number_of_people.to_i * stay_duration.to_i
  end
  
end
