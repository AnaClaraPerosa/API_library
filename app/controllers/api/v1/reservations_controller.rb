module Api
  module V1
    class ReservationsController < ApiV1Controller
      before_action :set_repository
      before_action :set_item, only: [:show, :update, :destroy]
      before_action :set_items, only: [:index]

      def index
        reservations = @repository.find_all
        success_response(response: reservations)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def show
        success_response(response: @reservation)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def create
        reservation = @repository.create(create_params)
        success_response(response: reservation)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def update
        @repository.update(@reservation, update_params)
        success_response(response: @reservation)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def destroy
        @repository.destroy(@reservation)
        success_response(response: @reservation)
      rescue StandardError => e
        error_response(response: e.message)
      end

      private

      def set_repository
        @repository = ReservationsRepository.new
      end

      def klass
        Reservation
      end

      def permitted_attributes
        [:user_id, :book_id, :reservation_date_start, :reservation_date_end]
      end
    end
  end
end
