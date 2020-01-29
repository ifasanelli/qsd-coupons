class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find(params[:id])
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)

    return redirect_to @promotion,
      notice: 'Promoção registrada com sucesso' if @promotion.save

    render :new
  end

  def edit
    @promotion = Promotion.find(params[:id])
  end

  def update
    @promotion = Promotion.find(params[:id])
    return redirect_to @promotion, notice: 'Promoção editada '\
      'com sucesso' if @promotion.update(promotion_params)

    render :edit
  end

  private

  def promotion_params
    params.require(:promotion).permit(:description, :prefix,
                                      :discount_percentage, :max_discount_value,
                                      :start_date, :end_date, :max_usage)
  end
end
