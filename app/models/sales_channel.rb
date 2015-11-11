class SalesChannel < ActiveRecord::Base
  belongs_to :user
  has_many :sales
  validates :name, presence: true

  def self.search(q)
    q = "%#{q}%"
    SalesChannel.where("name LIKE ? OR description LIKE ?", q, q)
  end

  def self.amount_by_channel
    items = []
    colors = ["#e92473", "#6ccd61"]
    channels = SalesChannel.all
    channel_ids = channels.pluck(:id)
    sales = Sale.where('sales_channel_id IN (?)', channel_ids)
    channels.each do |channel|
      applicable_sales = sales.select{|sale| sale.sales_channel_id == channel.id}
      sum_of_sales = applicable_sales.map{|sale| sale.gross}.reduce(:+)

      items << {"label": channel.name,
                "value": sum_of_sales.to_f,
                "color": colors.sample}
    end
    items
  end
end
