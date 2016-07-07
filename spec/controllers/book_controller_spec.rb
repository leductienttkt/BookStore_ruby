require 'rails_helper'

describe BooksController do
#*******************************************************************************
  let(:book) { create(:book) }
#*****************************************************************************
  describe "GET #index" do

    before { get :index }

    it "populates an array of books" do
      expect(assigns(:books)).to eq([book])
    end

    it "renders the index template" do
      expect(subject).to render_template(:index)
    end
  end

#*******************************************************************************
  describe "GET #show" do

    it "assigns the requested book to @book" do
      book = FactoryGirl.create(:book)
      get :show, id: book
      expect(assigns(:book)).to eq(book)
    end

    it "render the show template" do
      get :show, id: FactoryGirl.create(:book)
      expect(subject).to render_template(:show)
    end
  end
#*******************************************************************************
  describe "GET #new" do
    subject { get :new }

    it "render the new template" do
      expect(subject).to render_template(:new)
    end
  end
#*******************************************************************************
  describe "GET #edit" do
    subject { get :edit, :id => book.id.to_param }

    it "render the edit template" do
      expect(subject).to render_template(:edit)
    end
  end

#*******************************************************************************
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates the book' do
        post :create, book: attributes_for(:book)
        expect(Book.count).to eq(1)
      end

      it 'redirects to the "show" action for the new book' do
        post :create, book: attributes_for(:book)
        expect(response).to redirect_to :action =>:show,
                                     :id => assigns(:book).id
      end
    end

    context 'with invalid attributes' do
      it 'does not create the book' do
        post :create, book: attributes_for(:book, category_id:nil)
        expect(Book.count).to eq(0)
      end

      it 're-render the "new" view' do
        post :create, book: attributes_for(:book, category_id:nil)
        expect(response).to render_template :new
      end
    end
  end

#*******************************************************************************
  describe 'DELETE destroy' do
    before :each do
      @book = FactoryGirl.create(:book)
    end

    it "deletes the book" do
      expect{
        delete :destroy, id: @book
     }.to change(Book, :count).by(-1)
    end

    it "redirects to books#index" do
      delete :destroy, id: @book
      expect(response).to redirect_to books_url
    end
  end
#*******************************************************************************

  describe 'PUT #update' do
    before :each do
      @book = FactoryGirl.create(:book, title: "Co nhung thu ban khong the giai thich", category_id: 12)
    end

    context 'valid attributes' do
      it 'located the requested @book' do
        put :update, id: @book, book: attributes_for(:book)
        expect(assigns(:book)).to eq(@book)
      end

      it "change @book's attributes" do
        put :update, id: @book, book: attributes_for(:book, title: "Cai gi vay")
        @book.reload
        expect(@book.title).to eq("Cai gi vay")
      end

      it "redirects to the updated book" do
        put :update, id: @book, book: attributes_for(:book)
        expect(response).to redirect_to @book
      end
     end

    context 'invalid attributes' do
      it 'located the requested @book' do
        put :update, id: @book, book: attributes_for(:invalid_book)
        expect(assigns(:book)).to eq(@book)
      end

      it "does not change @book's attributes" do
        put :update, id: @book, book: attributes_for(:book, title: "Cai gi vay ", category_id: nil)
        @book.reload
        expect(@book.title).not_to eq("Cai gi vay")
        expect(@book.category_id).to eq(12)
      end

      it 're-renders the edit method' do
        put :update, id: @book, book: attributes_for(:invalid_book)
        expect(response).to render_template :edit
      end
    end
  end
end

