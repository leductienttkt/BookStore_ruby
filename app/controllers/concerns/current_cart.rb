module CurrentCart extend ActiveSupport::Concern
  private
  def set_cart
    # if cart isn't exist, create session cart
    unless session[:cart] then
      session[:cart] = {}
      session[:total_price] = 0
    end

    if current_user then
      @cart = Cart.where(user_id: current_user.id)
      if @cart.empty?
        @cart = Cart.create(user_id: current_user.id)
        binding.pry
      end
      temp1 = {}
      unless @cart.empty? then
        @cart.line_items.each do |item|
          temp1.store(item.book, item.quantity)
        end

        temp2 = temp1.dup

        session[:cart].each do |item, quantity|
          temp1.store(item, quantity)
        end

        temp1.each do |k1, v1|
          unless temp2.fetch(k1) then
            LineItem.create(k1.id.to_i, @cart.id, v1)
          end
        end
      else
        session[:cart].each do |k1, v1|
          binding.pry
          LineItem.create(k1.to_i, @cart.id, v1)
        end
      end
    end
  end
end
