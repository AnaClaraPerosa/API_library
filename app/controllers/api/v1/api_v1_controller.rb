module Api
  module V1
    class ApiV1Controller < ApplicationController
      before_action :set_item, only: [:show, :update, :destroy]
      before_action :set_items, only: [:index]

      rescue_from StandardError, with: :handle_standard_error

      private

      def klass
        raise NotImplementedError
      end

      def set_item
        instance_variable_set("@#{controller_name.singularize}", params[:id].present? ? @repository.find_by_id(params[:id]) : klass.new)
      end

      def set_items
        items = @repository.find_all
        items = apply_filters(items)
        instance_variable_set("@#{controller_name}", items)
      end

      def apply_filters(items)
        items
      end

      def create_params
        params.require(klass.name.underscore.to_sym).permit(permitted_attributes)
      end

      def update_params
        params.require(klass.name.underscore.to_sym).permit(permitted_attributes)
      end

      def permitted_attributes
        raise NotImplementedError
      end

      def handle_standard_error(error)
        render json: { error: error.message }, status: :unprocessable_entity
      end

      def success_response(response: nil)
        render json: response, status: :ok
      end

      def error_response(response: nil)
        render json: { error: response }, status: :unprocessable_entity
      end
    end
  end
end
