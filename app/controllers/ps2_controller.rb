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
      kill_quote(params[:kill_quote])
    end

    @dead_quotes = get_dead_quotes

    # Search for words in author and quote fields using regex in the SQL.
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

  def import 
    # TODO:  handle format errors.
    logger = Logger.new(STDOUT)
    file = params[:import_file]
    quotations = Hash.from_xml(file.read.as_json)["objects"]
    logger.info quotations
    quotations.each do |quotation|
      logger.info quotation

      new_quote = Quotation.new
      new_quote.author_name = quotation["author_name"]
      new_quote.category = quotation["category"]
      new_quote.quote = quotation["quote"]
      new_quote.created_at = quotation["created_at"]
      new_quote.updated_at = quotation["updated_at"]

      
      new_quote.save
    end

    logger.info "import over"
    flash[:notice] = 'Quotations successfully imported'
    redirect_back(fallback_location: :quotation)
  end

  def export
    logger = Logger.new(STDOUT)
    quotations = []
    Quotation.all.each do |quotation|
      quotations.push(quotation.as_json)
    end

    if params[:file_type] == "xml"
      send_data quotations.to_xml.to_s, :filename => "quotations.xml"
    else
      send_data quotations.to_json.to_s, :filename => "quotations.json"
    end
  end
end
