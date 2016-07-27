module CartHelper
  def item_total_price cost, quantity
    (cost * quantity).round(2)
  end
end
