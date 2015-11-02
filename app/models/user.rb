class User < ActiveRecord::Base
  has_many :projects
  has_many :sales_goals
  has_secure_password
end
