# encoding: UTF-8
require 'csv'

module Util
  class ImportCsv
    
    def initialize(file: nil)
      @file = File.open(file)
    end

    def process()
      
      csv_options = { 
        headers: true,
        col_sep: '|'),
        skip_blanks: true,
        row_sep: :auto,
        encoding: "UTF-8"
      }
      
      #header => id|date|content|author|nickname|1|2|3|4|5|6|7|8
      
      CSV.foreach(file, csv_options) do |record|
        user = User.where(name: record["author"]).first
        user ||= User.create(name: record["author"], nickname: record["nickname"])
        
        tweet = user.tweets.new
        tweet.tweet_id = record["id"]
        tweet.pub_date = record["date"]
        tweet.content = record["content"]
        
        (1..8).each do |count|
          tweet.ranks[count.to_s] = record[count.to_s].to_i if record[count.to_s]
        end
        tweet.save
      end 
      
    ensure
      @file.close
    end

      
  end
end
