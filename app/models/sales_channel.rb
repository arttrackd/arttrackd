class SalesChannel < ActiveRecord::Base
  belongs_to :sale
  validates :name, presence: true

end
