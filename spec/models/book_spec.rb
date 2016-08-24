require 'rails_helper'

RSpec.describe Book, type: :model do

  before(:all) do
    @book = FactoryGirl.create(:book)
  end

  subject { @book }

  describe " validate " do
    it { expect(@book).to be_valid }
    it { expect(@book).to be_truthy }

    it { expect(@book.title).to be_truthy }
    it { expect(@book.title.size).to be <=50  }

    it { expect(@book.cost).to be_truthy }
    it { expect(@book).to validate_numericality_of(:cost).is_greater_than_or_equal_to(1) }

    it { expect(@book.sale).to be_truthy }
    it { expect(@book).to validate_numericality_of(:sale).is_greater_than_or_equal_to(0) }
    it { expect(@book).to validate_numericality_of(:sale).is_less_than_or_equal_to(0.75) }

    it { expect(@book.weight).to be_truthy }
    it { expect(@book).to validate_numericality_of(:weight).is_greater_than_or_equal_to(10) }
    # it { expect(@book).to validate_numericality_of(:sale).is_less_than_or_equal_to(1) }

    it { expect(@book.photo).to be_truthy }

    it { expect(@book.content).to be_truthy }

    it { expect(@book.category_id).to be_truthy }
    it { expect(@book).to validate_numericality_of(:category_id).is_greater_than_or_equal_to(1).only_integer }

    it { expect(@book.publish_id).to be_truthy }
    it { expect(@book).to validate_numericality_of(:publish_id).is_greater_than_or_equal_to(1).only_integer }

    it { expect(@book.pages).to be_truthy }
    it { expect(@book).to validate_numericality_of(:pages).is_greater_than_or_equal_to(1).only_integer }
  end

  describe " associate " do
    it { expect(@book).to belong_to(:category) }
    it { expect(@book).to belong_to(:publish) }
    it { expect(@book).to have_many(:comments).dependent(:destroy) }
  end

end
