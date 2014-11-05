class ScrapperController < ApplicationController
  def scrap
    url = "http://omdbapi.com/?t=" + params[:movie]

    @response = HTTParty.get(URI.encode(url))

    render text: @response.body


  end
end
