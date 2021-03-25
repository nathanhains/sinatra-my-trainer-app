class User <ActiveRecord::Base
    has_secure_password
    validates :username, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true 
    has_many :exercises
    has_many :likes, through: :exercises
    include Slugifiable
    extend Slugifiable::ClassMethods
end