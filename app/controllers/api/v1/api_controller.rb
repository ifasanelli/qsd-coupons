module Api
  module V1
    class ApiController < ActionController::API
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      def render_not_found
        render json: { error: 'Cupom inexistente' }, status: :not_found
      end
    end
  end
end
