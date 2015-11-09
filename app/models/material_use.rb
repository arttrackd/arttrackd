class MaterialUse < ActiveRecord::Base
  belongs_to :material_purchase
  belongs_to :project
  belongs_to :user
  validates :name, presence: true
  validates :units, presence: true

  def self.search(q)
    search =  "%#{q}%"
    MaterialUse.where('name LIKE ? OR description LIKE ?', search, search)
  end
end
