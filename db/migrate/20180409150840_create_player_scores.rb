class CreatePlayerScores < ActiveRecord::Migration[5.1]
  def change
    create_table :player_scores do |t|
      t.references :player, foreign_key: true
      t.float :starting_11
      t.float :runs
      t.float :fours
      t.float :sixes
      t.float :str
      t.float :centuries
      t.float :duck
      t.float :wkts
      t.float :maiden
      t.float :er
      t.float :bonus
      t.float :catches
      t.float :runout
      t.float :total
      t.integer :match_id
      t.string :match

      t.timestamps
    end
  end
end
