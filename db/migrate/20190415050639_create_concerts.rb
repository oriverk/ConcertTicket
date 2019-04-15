# frozen_string_literal: true

class CreateConcerts < ActiveRecord::Migration[5.2]
  def change
    create_table :concerts do |t|
      t.text :infomation
      t.date :date

      t.timestamps
    end
  end
end
