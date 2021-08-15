class Daterange < ApplicationRecord
  belongs_to :user
  validates :name, :startDate, :data, presence: true
end
