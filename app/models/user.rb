class User <ActiveRecord::Base
    has_secure_password
    has_many :exercises
    include Slugifiable
    extend Slugifiable::ClassMethods
end