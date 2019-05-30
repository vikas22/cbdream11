class TeamPlayer < ApplicationRecord
  belongs_to :league
  belongs_to :user
  belongs_to :player
end
