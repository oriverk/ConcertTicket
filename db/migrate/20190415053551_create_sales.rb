# frozen_string_literal: true

class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :concert, foreign_key: true
      t.references :user, foreign_key: true
      t.string :grade
      t.integer :number_of_seats
      t.datetime :date
      t.integer :amount
      t.date :payment_deadline
      t.integer :used_point, default: 0

      t.timestamps
    end
  end
end
