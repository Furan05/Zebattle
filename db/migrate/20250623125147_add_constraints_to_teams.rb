class AddConstraintsToTeams < ActiveRecord::Migration[7.0]
  def change
    
    change_column :teams, :name, :string, limit: 50, null: false
    change_column :teams, :city, :string, null: false


    add_index :teams, :name, unique: true
  end
end
