class Ps2Controller < ApplicationController
  def index
  end

  def kill_quote(id)
    id = id.to_i
    if cookies[:dead_quotes]
      dead_quotes = JSON.parse cookies[:dead_quotes]
    else
      dead_quotes = []
    end
    dead_quotes.push(id)
    dead_quotes = dead_quotes.uniq
    cookies[:dead_quotes] = JSON.generate(dead_quotes)
  end

  def get_dead_quotes()
    if cookies[:dead_quotes]
      return JSON.parse cookies[:dead_quotes]
    else
      return []
    end
  end

  def quotation
    logger = Logger.new(STDOUT)

    if params[:revive_quote]
      cookies[:dead_quotes] = JSON.generate []
    end

    # Get all distinct categories.
    @category_options = Quotation.distinct.pluck(:category).map do |category|
      [category, category]
    end
    
    if params[:kill_quote]
      logger.info "KILLING QUOTE "+params[:kill_quote]
      kill_quote(params[:kill_quote])
    end

    @dead_quotes = get_dead_quotes

    # Search for words in autor and quote fields using regex in the SQL.
    @search_query = ""
    @original_query = ""
    if params[:search_query] and params[:search_query].strip != ""
      @search_query = params[:search_query]
      @original_query = params[:search_query]
      @search_query = "(\\m"+@search_query.downcase+"\\M)"
    end

    if params[:sort_by] == "date"
      @quotations = Quotation.where("LOWER(author_name) ~* ?  or LOWER(quote) ~* ?",
                                    @search_query, @search_query).where.not(id: get_dead_quotes)
                                    .order(:created_at)
    else
      @quotations = Quotation.where("LOWER(author_name) ~* ?  or LOWER(quote) ~* ?",
                                    @search_query, @search_query).where.not(id: get_dead_quotes)
                                    .order(:category)
    end
    logger.info get_dead_quotes

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