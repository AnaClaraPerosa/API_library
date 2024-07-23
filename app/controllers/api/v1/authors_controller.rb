module Api
  module V1
    class AuthorsController < ApiV1Controller
      before_action :set_repository
      before_action :set_item, only: [:show, :update, :destroy]
      before_action :set_items, only: [:index]

      def index
        authors = @repository.find_all
        success_response(response: authors)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def show
        success_response(response: @author)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def create
        author = @repository.create(create_params)
        success_response(response: author)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def update
        @repository.update(@author, update_params)
        success_response(response: @author)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def destroy
        @repository.destroy(@author)
        success_response(response: @author)
      rescue StandardError => e
        error_response(response: e.message)
      end

      private

      def set_repository
        @repository = AuthorsRepository.new
      end

      def klass
        Author
      end

      def permitted_attributes
        [:name]
      end
    end
  end
end
