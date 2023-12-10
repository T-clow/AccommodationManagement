class AddConfirmedAtToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :confirmed_at, :datetime
  end
end
