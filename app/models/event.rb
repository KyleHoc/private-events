class Event < ApplicationRecord
    belongs_to :creator, class_name: "User"
    has_many :registrations, foreign_key: "attended_event_id"
    has_many :attendees, through: :registrations
    validates :name, presence: true
    validates :location, presence: true
    validates :date, presence: true
    validates :creator_id, presence: true

    scope :past, -> { where("date < ?", Time.now)}
    scope :future, -> { where("date > ?", Time.now) }
end
