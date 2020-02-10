class Api::V1::ApiController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def render_not_found(exception)
    render json: { error: 'Cupom inexistente' }, status: :not_found
  end
end