class RenameInfomationColumnToConcerts < ActiveRecord::Migration[5.2]
  def change
    rename_column :concerts, :infomation, :information
  end
end
