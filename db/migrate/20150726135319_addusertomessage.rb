class Addusertomessage < ActiveRecord::Migration
  def change
    add_column :messages, :posted_by, :string
  end
end
