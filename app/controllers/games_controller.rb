require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = []
    20.times do
      @letters << ('a'..'z').to_a.sample
    end
  end

  def score
    params
    @points = 0
    url = "https://wagon-dictionary.herokuapp.com/autocomplete/#{params[:word]}"
    words_serialized = URI.open(url).read
    @words = JSON.parse(words_serialized)
    exist = @words['truncated_result']

    word = params[:word].chars
    grid = params[:letters].split
    test = word.all? { |letter| word.count(letter) <= grid.count(letter)}

    if @words["words"].include?(params[:word]) && exist
      @result = "give you points"
      @points += params[:word].length
    elsif exist
      @result = "is not a english word"
    else
      @result = "is not in the grid"
    end
  end

end
