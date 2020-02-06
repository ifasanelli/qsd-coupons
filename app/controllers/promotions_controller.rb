class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find(params[:id])
  end

  def new
    @promotion = Promotion.new
    @products = Product.all
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to @promotion, notice: 'Promoção registrada com sucesso'
    else
      @products = Product.all
      render :new
    end
  end

  def edit
    @products = Product.all
    @promotion = Promotion.find(params[:id])
  end

  def update
    @promotion = Promotion.find(params[:id])
    if @promotion.update(promotion_params)
      redirect_to @promotion, notice: 'Promoção editada com sucesso'
    else
      @products = Product.all
      render :edit
    end
  end

  private

  def promotion_params
    params.require(:promotion).permit(:description, :prefix,
                                      :discount_percentage, :max_discount_value,
                                      :start_date, :end_date, :max_usage,
                                      :product_type)
  end
end
