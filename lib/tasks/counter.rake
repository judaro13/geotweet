namespace :counter do
  task update: :environment do
    Tag.delete_all
    Tweet.all.each do |tweet|
      tweet.hashtags.each do |name|
        if tag = Tag.where(name: name).first
          tag.up_counter
        else
          Tag.create(name: name, lang: "en")
        end
      end
      
      rank={}
      tweet.ranks.values.each do |v|
        next if v == 0
        rank[v.to_s] ||= 0
        rank[v.to_s] += 1
        
      end
      
      rank = Hash[rank.sort.reverse]
      tweet.rank = rank.keys.last     
      tweet.save
      print "."
    end
    
    puts 'done!'
  end
  
  
  task ricardo: :environment do
    Ricardo.all.each do |tweet|
      t = Tweet.where(tweet_id: tweet.tweet_id).first
      t.rank_ling_pipe = tweet.rank_DynamicLMClassifier
      
      rank={}
      t.ranks.values.each do |v|
        next if v == 0
        rank[v.to_s] ||= 0
        rank[v.to_s] += 1
        
      end
      
      rank = Hash[rank.sort.reverse]
      t.rank_total_ling_pipe = rank.keys.last.to_i     
      t.save
      print "."
    end
    
    puts 'done!'
  end
  
  task stats: :environment do
#     StweetStat.delete_all
#     sstat = StweetStat.new
#     Stweet.all.each do |t|      
#       sstat.rank_lexicon[t.rank_total_lexicon] ||= 0 if t.rank_total_lexicon
#       sstat.rank_lexicon[t.rank_total_lexicon] += 1 if t.rank_total_lexicon
#       sstat.save!
#       print "."
#     end
    
    puts ""
    puts "*"*100
    puts ""
    TweetStat.delete_all
    stat = TweetStat.new
    Tweet.all.each do |t|
      stat.ranks[t.rank] ||= 0  if t.rank
      stat.ranks[t.rank] +=1 if t.rank
      
      stat.rank_lexicon[t.rank_total_lexicon] ||= 0 if t.rank_total_lexicon
      stat.rank_lexicon[t.rank_total_lexicon] += 1 if t.rank_total_lexicon
      
      stat.rank_ling_pipe[t.rank_total_ling_pipe] ||= 0 if t.rank_total_ling_pipe
      stat.rank_ling_pipe[t.rank_total_ling_pipe] += 1 if t.rank_total_ling_pipe
      stat.save
      print "."
    end
    
    puts 'done!'
  end
  
  
  task stweet: :environment do
    Stweet.where(city: nil).each do |t|
      t.save
      print "."
    end
    
    puts 'done!'
  end
end