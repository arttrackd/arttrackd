class MaterialUse < ActiveRecord::Base
  belongs_to :material_purchase
  belongs_to :project
  validates :name, presence: true
  validates :units, presence: true

end
