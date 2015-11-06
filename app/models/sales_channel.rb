class SalesChannel < ActiveRecord::Base
  belongs_to :user
  has_many :sales
  validates :name, presence: true

end
