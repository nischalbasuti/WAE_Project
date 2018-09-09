class Ps2Controller < ApplicationController
  def index
  end

  def quotation
    if params[:quotation]
      @quotation = Quotation.new( params.require(:quotation).permit(:author_name, :category, :quote) )
      if @quotation.save
        flash[:notice] = 'Quotation was successfully created.'
        @quotation = Quotation.new
      end
    else
      @quotation = Quotation.new
    end
    if params[:sort_by] == "date"
      @quotations = Quotation.order(:created_at)
    else
      @quotations = Quotation.order(:category)
    end
  end
end
