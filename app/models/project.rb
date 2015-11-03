class Project < ActiveRecord::Base
  belongs_to :user
  has_many :time_entries
  has_many :sales
  validates :name, presence: true
  validates :description, presence: true
  
end
