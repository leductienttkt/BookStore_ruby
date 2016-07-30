class CartController < ApplicationController

  # add item if user click add to cart
  def add
    id = params[:id]
    number = params[:number].to_i
    book = Book.find_by_id(id)
      # if the cart has already been created, use the existing cart else create a new cart
      if session[:cart] then
        cart = session[:cart]
      # else set new cart is a hash and session total_price have value = 0
    else
      session[:cart] = {}
      cart = session[:cart]
      session[:total_price] = 0
    end
      # if the product has already been added to the cart, increment the value else set th value to 1
      if cart[id] then
        cart[id] = cart[id] + number
      else
        cart[id] = number
      end
      # add value to total_price
      session[:total_price] = session[:total_price] + book.cost * number
      redirect_to :action => :index
  end # end add method

  # edit quantity of item if user edit quantity from page cart
  def editQuantity
    id = params[:id]
    number = params[:number].to_i
    cart = session[:cart]
    if cart[id] > number
      session[:total_price] = session[:total_price] - Book.find_by_id(id).cost * (cart[id] - number)
    else
      session[:total_price] = session[:total_price] + Book.find_by_id(id).cost * (number - cart[id])
    end
    cart[id] = number
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
    respond_to do |format|
      format.js
    end
    #redirect_to session[:previous_url]
  end

  # GET /carts
  # GET /carts.json
  def index
    binding.pry
    # if there is a cart, pass it to the page for display else pass an empty value
    if session[:cart] then
      @cart = session[:cart]
      @books = {}
      @cart.each do | id, quantity |
        item = Book.find_by_id(id)
        @books.store(item, quantity)
      end
    else
      @cart = {}
    end
  end
end
