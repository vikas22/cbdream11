class CreateTeamPlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_players do |t|
      t.references :league, foreign_key: true
      t.references :user, foreign_key: true
      t.references :player, foreign_key: true
      t.boolean :is_captain
      t.boolean :is_vice_captain

      t.timestamps
    end
  end
end
