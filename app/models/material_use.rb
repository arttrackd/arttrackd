class MaterialUse < ActiveRecord::Base
  belongs_to :material_purchase
  belongs_to :project
  validates :name, presence: true
  validates :units, presence: true

  def self.search(search)
    if search
      @material_uses = MaterialUse.where("name LIKE ?", "%#{search}%")
    end
  end
end
