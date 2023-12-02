class User < ApplicationRecord
  has_one_attached :avatar
  has_many :reservations, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, :trackable
  has_one_attached :avatar
  has_many :reservations, dependent: :destroy

  has_many :rooms
end
