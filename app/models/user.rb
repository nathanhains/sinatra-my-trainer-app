class User <ActiveRecord::Base
    has_secure_password
    has_many :exercises
    has_many :likes, through: :exercises
    include Slugifiable
    extend Slugifiable::ClassMethods
end