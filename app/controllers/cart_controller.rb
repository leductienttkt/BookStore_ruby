class CartController < ApplicationController
  before_action :get_cart, only: [:add,:editQuantity,:removeItem]

  # add item if user click add to cart
  def add
    id = params[:id]
    number = params[:number].to_i
    book = Book.find_by_id(id)
    cart = session[:cart]
      # if the product has already been added to the cart, increment the value else set th value to 1
      if cart[id] then
        cart[id] = cart[id] + number
      else
        cart[id] = number
      end
      # add value to total_price
      session[:total_price] = session[:total_price] + book.cost * number
      # add or edit item in database
      if @cart
        @item = @cart.line_items.find_by(book_id: id.to_i)
        if @item.blank?
          LineItem.create(cart_id: @cart.id, book_id: id.to_i, quantity: cart[id])
        else
          @item.update(quantity: cart[id])
        end
      end
      redirect_to :action => :index
  end # end add method

  # edit quantity of item if user edit quantity from page cart
  def editQuantity
    id = params[:id]
    @number = params[:number].to_i
    cart = session[:cart]
    @book = Book.find_by_id(id)
    if cart[id] > @number
      session[:total_price] = session[:total_price] - @book.cost * (cart[id] - @number)
    else
      session[:total_price] = session[:total_price] + @book.cost * (@number - cart[id])
    end
    cart[id] = @number
    if @cart
      @cart.line_items.find_by(book_id: id.to_i).update(quantity: cart[id])
    end

    respond_to do |format|
      format.js
    end
  end # end editQuantity method

  # clear All item in cart
  def clearCart
    session[:cart] = nil
    redirect_to :action => :index
  end

  # remove one item in cart
  def removeItem
    id = params[:id]
    cart = session[:cart]
    @book = Book.find_by_id(id)
    if cart[id] then
      session[:total_price] = session[:total_price] - @book.cost * cart[id]
      cart.delete(id)
    end
    if @cart
      @cart.line_items.find_by(book_id: id.to_i).delete
    end
    respond_to do |format|
      format.js
    end
    #redirect_to session[:previous_url]
  end

  # GET /carts
  # GET /carts.json
  def index
    # if there is a cart, pass it to the page for display else pass an empty value
    if session[:cart] then
      @books = {}
      session[:cart].each do | id, quantity |
        item = Book.find_by_id(id)
        @books.store(item, quantity)
      end
    else
      puts 'CC----------------CC'
    end
  end

  # if invalid cart happen, will return cart#index
  def invalid_cart
    redirect_to cart_path
  end

  private
  def get_cart
    if user_signed_in?
      @cart = Cart.find_by_user_id(current_user.id)
    end
  end
end
