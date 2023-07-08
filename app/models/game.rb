class Game < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    validates :min_age, numericality: { only_integer: true }, allow_blank: true
    validates :max_age, numericality: { only_integer: true }, allow_blank: true
    validates :min_duration, numericality: { only_integer: true }, allow_blank: true
    validates :max_duration, numericality: { only_integer: true }, allow_blank: true

    scope :search, -> (params) {
        p params
    }
end
