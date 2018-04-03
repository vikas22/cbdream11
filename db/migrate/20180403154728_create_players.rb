class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.string :name
      t.references :team, foreign_key: true
      t.references :user, foreign_key: true
      t.boolean :is_captain
      t.boolean :is_vice_captain

      t.timestamps
    end
  end
end
