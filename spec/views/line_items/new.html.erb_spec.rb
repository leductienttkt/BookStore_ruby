require 'rails_helper'

RSpec.describe "line_items/new", type: :view do
  before(:each) do
    assign(:line_item, LineItem.new(
      :book_id => 1,
      :quantity => 1,
      :price => 1.5
    ))
  end

  it "renders new line_item form" do
    render

    assert_select "form[action=?][method=?]", line_items_path, "post" do

      assert_select "input#line_item_book_id[name=?]", "line_item[book_id]"

      assert_select "input#line_item_quantity[name=?]", "line_item[quantity]"

      assert_select "input#line_item_price[name=?]", "line_item[price]"
    end
  end
end
