module CurrentCart extend ActiveSupport::Concern
  private
  def set_session
    # if cart isn't exist, create session cart
    unless session[:cart] then
      session[:cart] = {}
      session[:total_price] = 0
    end
  end

  def set_cart
    @cart = Cart.find_by(user_id: current_user.id)
    if @cart.blank?
      @cart = Cart.create(user_id: current_user.id)
    end
    temp1 = {}
    unless @cart.line_items.blank?
      session[:total_price] = 0
      @cart.line_items.each do |item|
        temp1.store(item.book_id, item.quantity)
        session[:total_price] += item.book.cost * item.quantity
      end

      temp2 = temp1.dup

      session[:cart].each do |item, quantity|
        temp1.store(item.to_i, quantity)
      end

      temp1.each do |k1, v1|
        unless temp2.has_key?(k1) then
          LineItem.create(book_id: k1.to_i, cart_id: @cart.id, quantity: v1)
          session[:total_price] += Book.find_by_id(k1.to_i).cost * v1
        end
      end
      session[:cart] = temp1.dup

    else
      session[:cart].each do |k1, v1|
        LineItem.create(book_id: k1.to_i, cart_id: @cart.id, quantity: v1)
      end
    end
  end
end
