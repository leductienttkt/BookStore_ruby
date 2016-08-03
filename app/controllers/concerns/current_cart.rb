module CurrentCart extend ActiveSupport::Concern
  private
  def set_cart
    # if cart isn't exist, create session cart
    unless session[:cart] then
      session[:cart] = {}
      session[:total_price] = 0
    end

    if user_signed_in?
      @cart = Cart.find_by_user_id(current_user.id)
      if @cart.blank?
        @cart = Cart.create(user_id: current_user.id)
      end
      temp1 = {}
      unless @cart.line_items.blank?
        @cart.line_items.each do |item|
          temp1.store(item.book_id, item.quantity)
        end

        temp2 = temp1.dup

        session[:cart].each do |item, quantity|
          temp1.store(item.to_i, quantity)
        end

        temp1.each do |k1, v1|
          binding.pry
          unless temp2.has_key?(k1) then
            binding.pry
            LineItem.create(book_id: k1.to_i, cart_id: @cart.id, quantity: v1)
          end
        end
      else
        session[:cart].each do |k1, v1|
          LineItem.create(book_id: k1.to_i, cart_id: @cart.id, quantity: v1)
        end
      end
    end
  end
end
