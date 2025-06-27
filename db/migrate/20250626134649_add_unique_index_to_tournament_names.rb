class AddUniqueIndexToTournamentNames < ActiveRecord::Migration[7.1]
  def change
    add_index :tournaments, :name, unique: true
  end
end
