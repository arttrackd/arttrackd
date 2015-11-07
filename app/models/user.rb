class User < ActiveRecord::Base
  has_many :projects
  has_many :sales_goals
  has_many :sales_channels
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true,
                      uniqueness: { case_sensitive: false },
                      format: {
                        with: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
                        message: "Not a valid email address",
                        on: :create
                      }
    validates :password, length: { minimum: 8 }, allow_nil: true
end
