class Addadmintouser < ActiveRecord::Migration
  def change
    add_column :User, :role, :string
  end
end
