# frozen_string_literal: true

class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.references :sale, foreign_key: true
      t.datetime :date
      t.integer :amount
      t.integer :added_point, default: 0

      t.timestamps
    end
  end
end
