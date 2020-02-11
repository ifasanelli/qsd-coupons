module Api
  module V1
    class CouponsController < Api::V1::ApiController
      def burn
        @coupon = Coupon.find_by(code: params[:code])
        return head :not_found if @coupon.blank?

        return head :forbidden if @coupon.burned?

        burn_successfully
      end

      private

      def burn_successfully
        burnt_coupon = \
          @coupon.register_coupon_usage(order_number: params[:order_number])
        return head :precondition_failed unless burnt_coupon.valid?

        render json: {
          code: @coupon.code, status: @coupon.status,
          order_number: @coupon.burnt_coupon.order_number,
          date: I18n.l(@coupon.burnt_coupon.date, format: :default)
        }, status: :ok
      end
    end
  end
end
