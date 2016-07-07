require "faker"

FactoryGirl.define do
  factory :book do
    category_id { Faker::Number.number(2) }
    title { Faker::Book.title }
    author { Faker::Book.author }
    publish_id { Faker::Number.number(2) }
    cost { Faker::Number.decimal(2) }
    sale { Faker::Number.between(0, 0.5) }
    photo { Faker::Avatar.image }
    content { Faker::Hipster.paragraph }
    weight {  Faker::Number.decimal(2) }
    size { Faker::Number.number(2) }
    pages { Faker::Number.number(2) }
    date { Faker::Time.backward(23, :morning) }
  end

  factory :invalid_book, parent: :book do
    category_id nil
  end
end
