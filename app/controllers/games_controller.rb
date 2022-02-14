require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    json_string = URI.open(url).read
    json_hash = JSON.parse(json_string)
    word = params[:word]
    letters = params[:letters].split(' ')

    @message = if json_hash['found'] == false
                 "Sorry but #{word.upcase} does not seem to be a valid English word ..."
               elsif word.chars.all? { |letter| word.count(letter) <= letters.count(letter.upcase) } == false
                 "Sorry but #{word.upcase} can't be built out of #{letters.join(',')}"
               else
                 "Congratulations! #{word.upcase} is a valid English word!"
               end
  end
end
