class SalesChannel < ActiveRecord::Base
  belongs_to :sale
  validates :name, presence: true

  def self.search(search)
    if search
      @sales_channels = SalesChannel.where("name LIKE ?", "%#{search}%")
    end
  end
end
