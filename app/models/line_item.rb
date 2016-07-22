class LineItem < ActiveRecord::Base
  belongs_to :book
  belongs_to :cart

  def total_price
    book.cost * quantity
  end
end
