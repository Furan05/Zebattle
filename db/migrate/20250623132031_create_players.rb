class CreatePlayers < ActiveRecord::Migration[7.0]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.string :position, null: false
      t.references :team, null: false, foreign_key: true
      t.timestamps
    end

    add_index :players, [:team_id, :name], unique: true
  end
end
