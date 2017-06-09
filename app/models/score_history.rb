class ScoreHistory < ApplicationRecord
  belongs_to :user	
  belongs_to :bonus_change	
end
