class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :tournament, null: false, foreign_key: true
      t.references :team1, null: false, foreign_key: { to_table: :teams }
      t.references :team2, null: false, foreign_key: { to_table: :teams }
      t.integer :team1_score, default: 0
      t.integer :team2_score, default: 0
      t.timestamps
    end

    add_index :matches, [:tournament_id, :team1_id, :team2_id], unique: true
  end
end
