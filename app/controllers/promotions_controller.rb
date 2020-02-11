class PromotionsController < ApplicationController
  def index
    @promotions = Promotion.all
  end

  def show
    @promotion = Promotion.find(params[:id])
    @coupons = @promotion.coupons
  end

  def new
    @promotion = Promotion.new
  end

  def create
    @promotion = Promotion.new(promotion_params)
    if @promotion.save
      redirect_to @promotion, notice: 'Promoção registrada com sucesso'
    else
      render :new
    end
  end

  def edit
    @promotion = Promotion.find(params[:id])
  end

  def update
    @promotion = Promotion.find(params[:id])
    if @promotion.update(promotion_params)
      redirect_to @promotion, notice: 'Promoção editada com sucesso'
    else
      render :edit
    end
  end

  def approve
    @promotion = Promotion.find(params[:id])
    @promotion.approved!
    record_approval
    redirect_to @promotion, notice: 'Promoção aprovada com sucesso'
  end

  def generate_coupons
    @promotion = Promotion.find(params[:id])
    @promotion.issued!
    @promotion.generate_coupons
    flash[:notice] = "Foram criados #{@promotion.max_usage} cupons"
    redirect_to @promotion
  end

  def generate_singles
    @promotion = Promotion.find(params[:id])
    @promotion.issued!
    @promotion.generate_single
    flash[:notice] = 'Foi criado mais 1 cupom'
    redirect_to @promotion
  end

  private

  def record_approval
    @promotion = Promotion.find(params[:id])
    @user = current_user
    @promotion_aproved = RecordApproval.create!(email: @user.email,
                                                date: Time.current.time,
                                                promotion_id: @promotion.id)
  end

  def promotion_params
    params.require(:promotion).permit(:description, :prefix,
                                      :discount_percentage, :max_discount_value,
                                      :start_date, :end_date, :max_usage)
  end
end
