class Project < ActiveRecord::Base
  belongs_to :user
  has_many :time_entries
  has_many :sales
  
end
