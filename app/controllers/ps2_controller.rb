class Ps2Controller < ApplicationController
  def index
  end

  def quotation
    # Get all distinct categories.
    @category_options = Quotation.distinct.pluck(:category).map do |category|
      [category, category]
    end
    
    @search_query = ""
    @original_query = ""
    if params[:search_query]
      @search_query = params[:search_query]
      @original_query = params[:search_query]
    end
    @search_query = "%"+@search_query+"%"

    if params[:sort_by] == "date"
      @quotations = Quotation.where("LOWER(author_name) LIKE ? or LOWER(quote) LIKE ?",
                                    @search_query.downcase, @search_query.downcase)
        .order(:created_at)
    else
      @quotations = Quotation.where("LOWER(author_name) LIKE ? or LOWER(quote) LIKE ?",
                                    @search_query.downcase, @search_query.downcase)
        .order(:category)
    end
    
    logger = Logger.new(STDOUT)
    logger.info @search_query

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
  end
end
