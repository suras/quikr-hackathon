class ChangeColumnName < ActiveRecord::Migration
  def change
  	rename_column :automobiles, :car_type, :v_type
  end
end
