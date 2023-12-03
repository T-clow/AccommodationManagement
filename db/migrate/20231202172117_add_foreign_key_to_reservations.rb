class AddForeignKeyToReservations < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :reservations, :users
  end
end
