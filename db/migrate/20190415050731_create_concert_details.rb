# frozen_string_literal: true

class CreateConcertDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :concert_details do |t|
      t.references :concert, foreign_key: true
      t.integer :grade
      t.integer :price
      t.integer :capacity

      t.timestamps
    end
  end
end
