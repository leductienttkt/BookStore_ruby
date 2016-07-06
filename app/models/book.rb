class Book < ActiveRecord::Base
  belongs_to :category
  belongs_to :publish
  validates :title, presence: true,
                    length: { maximum: 500 }
  validates :cost, presence:true,
                   numericality: { greater_than_or_equal_to: 1 }
  validates :sale, presence:true,
                   numericality: { greater_than_or_equal_to: 0,
                                   is_less_than_or_equal_to: 0.75 }
  validates :photo,presence: true
  validates :content, presence: true
  validates :category_id, presence: true,
                          numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :publish_id, presence: true,
                          numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :pages, presence: true,
                          numericality: { only_integer: true, greater_than_or_equal_to: 1 }

 def self.book_list(page)
  @book = Book.paginate(:page => page, :per_page => 12)
 end

end
