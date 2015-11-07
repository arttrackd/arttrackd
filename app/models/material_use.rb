class MaterialUse < ActiveRecord::Base
  belongs_to :material_purchase
  belongs_to :project


  def self.search(search)
    if search
      @material_uses = MaterialUse.where("name LIKE ?", "%#{search}%")
    end
  end
end
