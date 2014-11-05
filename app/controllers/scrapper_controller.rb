class ScrapperController < ApplicationController
  def scrap
    url = "http://omdbapi.com/?t=" + params[:movie]

    @response = HTTParty.get(URI.encode(url))

    @movie = Movie.new
    @result = JSON.parse(@response.body)
    if @result["Title"] == nil
      return render json: {:error => "COULDNT FIND THAT MOVIE :( "}.to_json
    end
    if( Movie.exists?(title: @result["Title"]) and Movie.exists?(year: @result["Year"] ))
      return render json: {:error => "THAT MOVIE IS ALREADY IN THE DB :( "}.to_json
    end
    @movie.title = @result["Title"]
    @movie.director = @result["Director"]
    @movie.year = @result["Year"]
    @movie.plot = @result["Plot"]


    if @movie.save
      render json: @movie
    else
      render json: {:error => "MEGAFAIL!"}.to_json
    end
  end
end