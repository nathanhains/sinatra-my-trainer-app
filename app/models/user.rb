class User <ActiveRecord::Base
    has_secure_password
    validates :username, presence: true
    validates :email, presence: true
    validates :email, uniqueness: true 
    has_many :friends
    has_many :exercises
    has_many :likes, through: :exercises, dependent: :destroy
    include Slugifiable
    extend Slugifiable::ClassMethods
end