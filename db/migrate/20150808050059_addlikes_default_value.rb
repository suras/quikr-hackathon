class AddlikesDefaultValue < ActiveRecord::Migration
  def change
  	change_column :automobiles, :likes, :integer, :default => 0
  end
end
