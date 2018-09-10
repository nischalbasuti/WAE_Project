class Ps2Controller < ApplicationController
  def index
  end

  def quotation
    # Get all distinct categories.
    @category_options = Quotation.distinct.pluck(:category).map do |category|
      [category, category]
    end
    
    # Search for words in autor and quote fields using regex in the SQL.
    @search_query = ""
    @original_query = ""
    if params[:search_query] and params[:search_query].strip != ""
      @search_query = params[:search_query]
      @original_query = params[:search_query]
      @search_query = "(\\m"+@search_query.downcase+"\\M)"
    end

    if params[:sort_by] == "date"
      @quotations = Quotation.where("LOWER(author_name) ~* ?
                                    or LOWER(quote) ~* ?",
                                    @search_query, @search_query)
                                    .order(:created_at)
    else
      @quotations = Quotation.where("LOWER(author_name) ~* ?
                                    or LOWER(quote) ~* ?",
                                    @search_query, @search_query)
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
