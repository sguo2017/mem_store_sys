class ScoreHistory < ApplicationRecord
  belongs_to :user, dependent: :destroy
end
