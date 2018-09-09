class Ps2Controller < ApplicationController
  def index
  end

  def quotation
    # Get all distinct categories.
    @category_options = Quotation.distinct.pluck(:category).map do |category|
      [category, category]
    end

    # Create a new quotation if passed.
    if params[:quotation]
      @quotation = Quotation.new( params.require(:quotation).permit(:author_name, :category, :quote) )
      if params[:new_category].strip != ""
        @quotation[:category] = params[:new_category]
      end
      if @quotation.save
        flash[:notice] = 'Quotation was successfully created.'
        @quotation = Quotation.new
      end
    else
      @quotation = Quotation.new
    end

    # Order of quotations.
    if params[:sort_by] == "date"
      @quotations = Quotation.order(:created_at)
    else
      @quotations = Quotation.order(:category)
    end
  end
end
