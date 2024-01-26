require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    letters = ('A'..'Z').to_a;
    @letters_array = letters.sample(10).join;
    @initial_time = Time.now;
  end

  def score
    mots = params[:mots].upcase.chars;
    token = params[:token];
    puts token.class

    initial_time = params[:initial_time].to_datetime;


    if checkValidWord?(mots, token) && parseDictionnary?(mots)
      @bool= true;
      end_time = Time.now
      @mots = mots
      @dixlettres = token
      @calculatedTime = end_time - initial_time
      @score = (mots.length * 0.5) - (@calculatedTime * 0.2)
    else
      puts "bad";
    end
  end

  private

   def checkValidWord?(mots, token)
    mots.all? {|letter| mots.count(letter) <=  token.count(letter)}
   end

   def parseDictionnary?(mots)
    url = "https://wagon-dictionary.herokuapp.com/#{mots.join}"
    puts JSON.parse(URI.open(url).read)["found"]
    JSON.parse(URI.open(url).read)["found"]
   end

end
