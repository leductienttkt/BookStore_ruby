module CurrentCart
  extend ActiveSupport::Concern

  private def set_cart
    if current_user.nil?
      return using_for_session
    else
      return using_for_data
    end
  end

  def using_for_data
    @cart = Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
  end

  def using_for_session
    if session[:cart].nil?
      session[:cart] = {}
    end
    @cart = session[:cart]
  end
end
