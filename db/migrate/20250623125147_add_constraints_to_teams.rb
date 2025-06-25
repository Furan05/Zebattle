class AddConstraintsToTeams < ActiveRecord::Migration[7.0]
  def change
    # Changer la limite de caractères pour name
    change_column :teams, :name, :string, limit: 50, null: false
    change_column :teams, :city, :string, null: false

    # Ajouter l'index unique sur name
    add_index :teams, :name, unique: true
  end
end
