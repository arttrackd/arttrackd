class MaterialPurchase < ActiveRecord::Base
  belongs_to :user
  has_many :material_uses
  validates :name, presence: true
  validates :cost, presence: true
  validates :units, presence: true

  def self.search(q)
    search =  "%#{q}%"
    MaterialPurchase.where('name LIKE ? OR description LIKE ?', search, search).order(:name)
  end
end
