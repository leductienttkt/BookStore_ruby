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
  - logined & no_login: compute dependent case 
=end
  def price book
    (book.cost - book.cost * book.sale).round(2) 
  end

  def sale book
    (book.cost * book.sale).round(2)
  end

  def price_line_item book, quantity
    price(book) * quantity
  end

  def cart_count
    if current_user.nil?
      no_login(false)
    else
      logined(false)
    end
  end

  def cart_price
    if current_user.nil?
      no_login(true)
    else
      logined(true)
    end
  end

  def logined (is_price)
    @result = 0
    unless session[:cart_id].nil?
      if @cart.nil?
        @cart = Cart.find(session[:cart_id])
        return @result
      end
      if is_price
        @cart.line_items.includes(:book).each{ |item|
          @result += item.quantity * price(item.book)
        }
      else
        @cart.line_items.includes(:book).each{ |item|
          @result += item.quantity
        }
      end
    end
    @result
  end

  def no_login is_price
    @result = 0
    if is_price
      @cart.each do |id, quantity|
        @result += quantity * price(Book.find(id))
      end
    else
      @cart.each do |id, quantity|
        @result += quantity
      end
    end
    @result
  end
end
