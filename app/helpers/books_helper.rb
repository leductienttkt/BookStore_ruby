module BooksHelper
=begin
 CREATE: pdkpro
 DATE: 30/7/2016
 CONTENT: resolve code complex in view.
  - price: computer price of a book after sale
  - sale: computer the money be sale
  - price_line_item: computer total price of a line_item (hash quantiy)
  - cart_count: computer the line_item in a current_cart
  - cart_price: computer the price of all line_item in current_cart
=end
  def price book
    (book.cost - book.cost * book.sale).round(2) 
  end

  def sale book
    (book.cost * book.sale).round(2)
  end

  def price_line_item line_item
    price(line_item.book) * line_item.quantity
  end

  def cart_count
    @count = 0
    unless session[:cart_id].nil?
      if @cart.nil?
        @cart = Cart.find(session[:cart_id])
      end
      @cart.line_items.includes(:book).each{ |item|
        @count += item.quantity
      }
    end
    @count
  end

  def cart_price
    @price = 0
    unless session[:cart_id].nil?
      if @cart.nil?
        @cart = Cart.find(session[:cart_id])
      end
      @cart.line_items.includes(:book).each{ |item|
        @price += item.quantity * price(item.book)
      }
    end
    @price
  end
end
