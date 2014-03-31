# encoding: UTF-8
require 'csv'

# c = ImportCsv.new
# c.process

class ImportCsv
  attr_writer     :file
  
  def initialize(file = "/home/juliana/Uniandes/bigdata/lab3/geotwits/public/dataset.csv")
    @file = file
  end

  def process()
    puts "Begining"
    csv_options = { 
      headers: true,
      col_sep: '|',
      skip_blanks: true,
      row_sep: :auto,
      encoding: "UTF-8"
    }
    #          0   1    2       3      4       5 6 7 8 9 10 11 12
    #header => id|date|content|author|nickname|1|2|3|4|5|6|7|8
    c = 0
    File.readlines(@file).each do |line|
      record = line.split("|")
      user = User.where(name: record[3]).first
      user ||= User.create(name: record[3], nickname: record[4])
      
      tweet = user.tweets.new
      tweet.tweet_id = record[0].to_s
      begin
        tweet.pub_date = DateTime.strptime(record[1].to_s, '%m/%d/%y %H:%M')
      rescue
        binding.pry
      end
      tweet.content = record[2].to_s
      
      (5..12).each do |count|
        tweet.ranks[count.to_s] = record[count].to_i if record[count]
      end
      tweet.save
      puts c += 1
    end 
    puts "done"
  end

    
end
