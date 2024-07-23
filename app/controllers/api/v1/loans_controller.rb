module Api
  module V1
    class LoansController < ApiV1Controller
      before_action :set_repository
      before_action :set_item, only: [:show, :update, :destroy]
      before_action :set_items, only: [:index]

      def index
        loans = @repository.find_all
        success_response(response: loans)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def show
        success_response(response: @loan)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def create
        loan = @repository.create(create_params)
        success_response(response: loan)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def update
        @repository.update(@loan, update_params)
        success_response(response: @loan)
      rescue StandardError => e
        error_response(response: e.message)
      end

      def destroy
        @repository.destroy(@loan)
        success_response(response: @loan)
      rescue StandardError => e
        error_response(response: e.message)
      end

      private

      def set_repository
        @repository = LoansRepository.new
      end

      def klass
        Loan
      end

      def permitted_attributes
        [:user_id, :book_id, :loan_date_start, :loan_date_end]
      end
    end
  end
end
