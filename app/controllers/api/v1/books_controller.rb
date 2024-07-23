module Api
  module V1
    class BooksController < ApiV1Controller
      before_action :set_repository
      before_action :set_item, only: [:show, :update, :destroy]
      before_action :set_items, only: [:index]

      def index
        books = @repository.find_all
        success_response(response: books)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def show
        success_response(response: @book)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def create
        book = @repository.create(create_params)
        success_response(response: book)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def update
        @repository.update(@book, update_params)
        success_response(response: @book)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def destroy
        @repository.destroy(@book)
        success_response(response: @book)
      rescue StandardError => e
        error_response(response: e.message)
      end

      private

      def set_repository
        @repository = BooksRepository.new
      end

      def klass
        Book
      end

      def permitted_attributes
        [:title, :description, :author_id, :category_id]
      end
    end
  end
end