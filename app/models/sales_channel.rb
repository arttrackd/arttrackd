class SalesChannel < ActiveRecord::Base
  belongs_to :user
  has_many :sales
  validates :name, presence: true

  def self.search(sc, q)
    @sales_channels = sc.where("name LIKE ?", q)
  end
end
