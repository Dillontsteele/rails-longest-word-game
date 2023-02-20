require "open-uri"

class GamesController < ApplicationController
  def new
    array = ('a'..'z').to_a
    @letters = array.sample(10).join
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    @english_word = english_word?(@word)
    @include = include?(@word, @letters)
  end

  private

  def include?(word, letters)
    word.split.all? { |char| letters.include?(char) }
  end
  p @include

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}").read
    json = JSON.parse(response)
    json["found"]
  end
end
