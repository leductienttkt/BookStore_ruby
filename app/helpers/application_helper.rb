module ApplicationHelper

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def total_quantity
    total = 0
    if session[:cart] then
      cart = session[:cart]
      cart.inject(0) { |total, (k, v)| total + v }
    else
      total
    end
  end

  def total_price
  end
end
