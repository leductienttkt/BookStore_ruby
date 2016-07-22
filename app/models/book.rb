# book model
class Book < ActiveRecord::Base
  belongs_to :category
  belongs_to :publish
  has_many :comments
  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, presence: true,
                    length: { maximum: 500 }
  validates :cost, presence: true,
                   numericality: { greater_than_or_equal_to: 1 }
  validates :sale, presence: true,
                   numericality: { greater_than_or_equal_to: 0, is_less_than_or_equal_to: 0.75 }
  validates :photo, presence: true
  validates :content, presence: true
  validates :category_id, presence: true,
                          numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :publish_id,  presence: true,
                          numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :pages, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  PER_PAGE = 12

  def self.book_list(page)
    @book = Book.paginate(page: page, per_page: PER_PAGE)
  end

  private
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
end
