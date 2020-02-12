module Api
  module V1
    class CouponsController < Api::V1::ApiController
      def confer
        @coupon = Coupon.find_by!(code: params[:coupon])

        return confer_succesfully if @coupon.confer?(params[:product])

        confer_unsuccesfully
      end

      def burn
        @coupon = Coupon.find_by(code: params[:code])
        return head :not_found if @coupon.blank?

        return head :forbidden if @coupon.burnt?

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

      def confer_succesfully
        discount = @coupon.calculate_discount(params[:price].to_i)
        render json: { discount: discount }, status: :ok
      end

      def confer_unsuccesfully
        render json: { error: @coupon.errors[:base].join },
               status: :unprocessable_entity
      end
    end
  end
end
