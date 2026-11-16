require "open-uri"
require "json"

class PagesController < ApplicationController
  def new
    @letters = []
    count = 0
    while count <  8
      @letters << ("a".."z").to_a.sample(1)
      count +=1
    end
    @letters
  end

  def score
  url = "https://dictionary.lewagon.com/#{params[:word]}"
  system_response = URI.parse(url).read
  response = JSON.parse(system_response)
  succes = nil
  error_message = ""
  letter_arr = params[:word].split("")
  if response["found"] == true
    letter_arr.each do |i|
      if params[:letters].include?(i)
        params[:letters].delete(i)
        succes = true
      elsif params[:letters].include?(i) == false
        error_message = "not in the grid"
        succes = false
      end
    end
  elsif succes != false && response["found"] == false
    error_message = "not an english word"
    succes = false
  end
  if succes == true
    @result = "GGs"
  else
    @result = error_message
  end
  @result
  end
end
