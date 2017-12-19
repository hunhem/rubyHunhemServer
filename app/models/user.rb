class User < ActiveRecord::Base
	has_many :scores, :dependent => :destroy
end
