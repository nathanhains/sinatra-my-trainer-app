class Exercise < ActiveRecord::Base
    belongs_to :user
    has_many :likes
    def self.find_case_insensitive(name)
        Exercise.all.find do |exercise|
            name.downcase == exercise.name.downcase
        end
    end
end
