class Ps1Controller < ApplicationController
  def index
  end

  def divide
    @denominator = params[:denominator].to_f == 0.0 ? 0 : params[:denominator].to_f
    @error = false
    @error_message = ""
    begin
      @a = 10/@denominator
    rescue ZeroDivisionError => e
      # @error = e.backtrace.inspect
      # @logger = Logger.new(STDERR)
      @logger = Logger.new("log/production.log")
      @logger.error "About to divide by 0"
      @error = true
      @error_message = e
      # raise ZeroDivisionError
    end
  end
  def divide_exception
    10/0
  end

  def news
    require 'open-uri'
    url = "https://news.google.com/topics/CAAqJggKIiBDQkFTRWdvSUwyMHZNRGx1YlY4U0FtVnVHZ0pWVXlnQVAB?hl=en-US&gl=US&ceid=US%3Aen"
    doc = Nokogiri::HTML(open(url))
    
    @body = doc.css(".FVeGwb.NLCVwf")[0]

    @items = doc.css(".NiLAwe.y6IFtc.R7GTQ.keNKEd.j7vNaf.nID9nc")

    require 'net/http'
    # get images
    @img_urls = []
    @headlines = []
    @urls = []
    for item in @items
      @img_urls.push(URI.parse(item.css(".tvs3Id.dIH98c").xpath("@src").to_s).to_s)
      @headlines.push(item.css(".ipQwMb.Q7tWef")[0].css("span").xpath("text()").to_s)
      @urls.push(URI.parse("https://news.google.com/"+item.css(".MQsxIb.xTewfe.R7GTQ.keNKEd.j7vNaf.Cc0Z5d.YKEnGe.EyNMab.t6ttFe.Fm1jeb.EjqUne").css(".VDXfz")[0].xpath("@href").to_s).to_s)
    end
  end
end
