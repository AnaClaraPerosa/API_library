module Api
  module V1
    class CategoriesController < ApiV1Controller
      before_action :set_repository
      before_action :set_item, only: [:show, :update, :destroy]
      before_action :set_items, only: [:index]

      def index
        categories = @repository.find_all
        success_response(response: categories)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def show
        success_response(response: @category)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def create
        category = @repository.create(create_params)
        success_response(response: category)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def update
        @repository.update(@category, update_params)
        success_response(response: @category)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def destroy
        @repository.destroy(@category)
        success_response(response: @category)
      rescue StandardError => e
        error_response(response: e.message)
      end

      private

      def set_repository
        @repository = CategoriesRepository.new
      end

      def klass
        Category
      end

      def permitted_attributes
        [:name]
      end
    end
  end
end
