module Api
  module V1
    class UsersController < ApiV1Controller
      before_action :set_repository
      before_action :set_item, only: [:show, :update, :destroy]
      before_action :set_items, only: [:index]

      def index
        users = @repository.find_all
        success_response(response: users)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def show
        success_response(response: @user)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def create
        user = @repository.create(create_params)
        success_response(response: user)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def update
        @repository.update(@user, update_params)
        success_response(response: @user)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def destroy
        @repository.destroy(@user)
        success_response(response: @user)
      rescue StandardError => e
        error_response(response: e.message)
      end

      private

      def set_repository
        @repository = UsersRepository.new
      end

      def klass
        User
      end

      def permitted_attributes
        [:name, :email]
      end
    end
  end
end
