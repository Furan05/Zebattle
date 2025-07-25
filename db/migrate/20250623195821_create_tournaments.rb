class CreateTournaments < ActiveRecord::Migration[7.0]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false
      t.string :status, default: 'pending'
      t.timestamps
    end
  end
end
