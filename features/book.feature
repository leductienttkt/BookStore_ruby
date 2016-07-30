Feature: Books page

Scenario: Viewing application's books page
  Given there're a book titled "My book" photo "Myphoto.jpg" with cost 2 sale 1 category "my category" publish "my publish" author "my authour" content "my content" weight 500 size "50x50" pages 55 date "2016-07-14 21:58:10 +0700"
  When I am on the books
  Then I should see the "My book" image "Myphoto.jpg" with cost 2 and 1 book

Scenario: View'ing details of a book
  Given there're a book titled "My book" photo "Myphoto.jpg" with cost 2 sale 1 category "my category" publish "my publish" author "my authour" content "my content" weight 500 size "50x50" pages 55 date "2016-07-14 21:58:10 +0700"
  When I am on the book details
  Then I should see book titled "My book" image "Myphoto.jpg" with cost 2 sale 1 category "my category" publish "my publish" author "my authour" content "my content" weight 500 size "50x50" date "2016-07-14 21:58:10 +0700"

Scenario: Create a new book valid
  Given I am on book path "/books/new" with category_id 1 publish_id 1
  When I fill in title "book[title]" with "my book", photo "book[photo]" with "myphoto.jpg", cost "book[cost]" with 2, sale "book[sale]" with 1, category_id "book[category_id]" with 1, publish_id "book[publish_id]" with 1, author "book[author]" with "my authour", content "book[content]" with "my content", weight "book[weight]" with 500, size "book[size]" with "50x50", pages "book[pages]" with 55 and date "book[date]" is "2016-07-14 21:58:10 +0700"
  When I press "Create Book"
  Then I should see "Book was successfully created."

Scenario: Create a new book inalid
  Given I am on book path "/books/new" with category_id 1 publish_id 1
  When I fill in title "book[title]" with "", photo "book[photo]" with "", cost "book[cost]" with 0, sale "book[sale]" with 0, category_id "book[category_id]" with 1, publish_id "book[publish_id]" with 1, author "book[author]" with "my authour", content "book[content]" with "", weight "book[weight]" with 4, size "book[size]" with "50x50", pages "book[pages]" with 0 and date "book[date]" is "2016-07-14 21:58:10 +0700"
  When I press "Create Book"
  Then I should see "Title can't be blank."
  Then I should see "Photo can't be blank."
  Then I should see "Content can't be blank."
  Then I should see "Cost can't less than 1."
  Then I should see "Sale can't less than 1."
  Then I should see "Pages can't less than 1."
  Then I should see "Weight can't less than 10."


Scenario: update a book valid
  Given I am on edit book path with category_id 1 publish_id 1
  When I fill in title "book[title]" with "my book", photo "book[photo]" with "myphoto.jpg", cost "book[cost]" with 2, sale "book[sale]" with 1, category_id "book[category_id]" with 1, publish_id "book[publish_id]" with 1, author "book[author]" with "my authour", content "book[content]" with "my content", weight "book[weight]" with 500, size "book[size]" with "50x50", pages "book[pages]" with 55 and date "book[date]" is "2016-07-14 21:58:10 +0700"
  When I press update_book_button "Update Book"
  Then I should see content "Book was successfully updated."

Scenario: update a book inalid
  Given I am on edit book path with category_id 1 publish_id 1
  When I fill in title "book[title]" with "my book", photo "book[photo]" with "myphoto.jpg", cost "book[cost]" with 2, sale "book[sale]" with 1, category_id "book[category_id]" with 1, publish_id "book[publish_id]" with 1, author "book[author]" with "my authour", content "book[content]" with "my content", weight "book[weight]" with 500, size "book[size]" with "50x50", pages "book[pages]" with 55 and date "book[date]" is "2016-07-14 21:58:10 +0700"
  When I press update_book_button "Update Book"
  Then I should see content "Title can't be blank."
  Then I should see content "Photo can't be blank."
  Then I should see content "Content can't be blank."
  Then I should see content "Cost can't less than 1."
  Then I should see content "Sale can't less than 1."
  Then I should see content "Pages can't less than 1."
  Then I should see content "Weight can't less than 10."

Scenario: Viewing application's books page destroy something
  Given there're a book titled "My book" photo "Myphoto.jpg" with cost 2 sale 1 category "my category" publish "my publish" author "my authour" content "my content" weight 500 size "50x50" pages 55 date "2016-07-14 21:58:10 +0700"
  When I visit destroy_book_link
  Then I should see destroy_book_content "Book was successfully destroyed."
