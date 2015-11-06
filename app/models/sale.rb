class Sale < ActiveRecord::Base
  belongs_to :project
  belongs_to :sales_channel
  validates :gross, presence: true
  validates :date, presence: true

end
