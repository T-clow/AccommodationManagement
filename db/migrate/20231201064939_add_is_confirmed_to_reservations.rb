class AddIsConfirmedToReservations < ActiveRecord::Migration[6.0]
  def change
    add_column :reservations, :c, :boolean, default: false
  end
end
