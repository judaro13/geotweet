module ApplicationHelper
  def tsdb_tweets
    stats = TweetStat.first
    {  "name" => "flare", 
              :children => [
                 {"name" => "negativo", "size" => stats.ranks["1"]},
                 {"name" => "positivo", "size" => stats.ranks["2"]},
                 {"name" => "mixto", "size" => stats.ranks["3"]},
                 {"name" => "otro", "size" => stats.ranks["4"]}
                 ]}.to_json
  end
  
  def lbsa_tweets
    stats = TweetStat.first
    {  "name" => "flare", 
              :children => [
                            {"name" => "neutro", "size" => stats.rank_lexicon["1"]},
                            {"name" => "algo negativo", "size" => stats.rank_lexicon["-2"]},
                            {"name" => "negativo", "size" => stats.rank_lexicon["-3"]},
                            {"name" => "muy negativo", "size" => stats.rank_lexicon["-4"]},
                            {"name" => "super negativo", "size" => stats.rank_lexicon["-5"]},
                            {"name" => "algo positivo", "size" => stats.rank_lexicon["2"]},
                            {"name" => "positivo", "size" => stats.rank_lexicon["3"]},
                            {"name" => "muy positivo", "size" => stats.rank_lexicon["4"]},
                            {"name" => "super positivo", "size" => stats.rank_lexicon["5"]}
                        ]}.to_json
  end
  
  def ling_pipe_tweets
    stats = TweetStat.first
    {  "name" => "flare", 
              :children => [
                          {"name" => "negativo", "size" => stats.rank_ling_pipe["1"]},
                          {"name" => "positivo", "size" => stats.rank_ling_pipe["2"]},
                          {"name" => "mixto", "size" => stats.rank_ling_pipe["3"]},
                          {"name" => "otro", "size" => stats.rank_ling_pipe["4"]}
                        ]}.to_json
  end
  
  def tsdb_tags
    tags_draw = []
    tags = @tags.map{|t| t.name}
    tags[0..2].each do |t|
      tag_hash = {}
      tag_hash["Tweet"] = t
      tag_hash["negativo"] = Tweet.where(:hashtags.in => [t], :rank => 1).count
      tag_hash["positivo"] = Tweet.where(:hashtags.in => [t], :rank => 2).count
      tag_hash["mixto"] = Tweet.where(:hashtags.in => [t], :rank => 3).count
      tag_hash["otro"] = Tweet.where(:hashtags.in => [t], :rank => 4).count
      tags_draw << tag_hash
    end
    tags_draw.to_json
  end
  
  def lbsa_tags
    tags_draw = []
    tags = @tags.map{|t| t.name}
    tags[0..2].each do |t|
      tag_hash = {}
      tag_hash["Tweet"] = t
      tag_hash["neutro"] = Tweet.where(:hashtags.in => [t], :rank_total_lexicon => 1).count
      tag_hash["algo negativo"] = Tweet.where(:hashtags.in => [t], :rank_total_lexicon => -2).count
      tag_hash["negativo"] = Tweet.where(:hashtags.in => [t], :rank_total_lexicon => -3).count
      tag_hash["muy negativo"] = Tweet.where(:hashtags.in => [t], :rank_total_lexicon => -4).count
      tag_hash["super negativo"] = Tweet.where(:hashtags.in => [t], :rank_total_lexicon => -4).count
      tag_hash["algo positivo"] = Tweet.where(:hashtags.in => [t], :rank_total_lexicon => 2).count
      tag_hash["positivo"] = Tweet.where(:hashtags.in => [t], :rank_total_lexicon => 3).count
      tag_hash["muy positivo"] = Tweet.where(:hashtags.in => [t], :rank_total_lexicon => 4).count
      tag_hash["super positivo"] = Tweet.where(:hashtags.in => [t], :rank_total_lexicon => 5).count
      tags_draw << tag_hash
    end
    tags_draw.to_json
  end
  
  def ling_pipe_tags
    tags_draw = []
    tags = @tags.map{|t| t.name}
    tags[0..2].each do |t|
      tag_hash = {}
      tag_hash["Tweet"] = t
      tag_hash["negativo"] = Tweet.where(:hashtags.in => [t], :rank_total_ling_pipe => 1).count
      tag_hash["positivo"] = Tweet.where(:hashtags.in => [t], :rank_total_ling_pipe => 2).count
      tag_hash["mixto"] = Tweet.where(:hashtags.in => [t], :rank_total_ling_pipe => 3).count
      tag_hash["otro"] = Tweet.where(:hashtags.in => [t], :rank_total_ling_pipe => 4).count
      tags_draw << tag_hash
    end
    tags_draw.to_json
  end
  
  def tsdb_tweets_by_tag(tag)
    {  "name" => "flare", 
       :children => [
                     {"name" => "negativo", "size" => Tweet.where(:hashtags.in => [tag], rank: 1).count},
                     {"name" => "positivo", "size" => Tweet.where(:hashtags.in => [tag], rank: 2).count},
                     {"name" => "mixto", "size" => Tweet.where(:hashtags.in => [tag], rank: 3).count},
                     {"name" => "otro", "size" => Tweet.where(:hashtags.in => [tag], rank: 4).count}
                    ]}.to_json
  end
  
  def lbsa_tweets_by_tag(tag)
    {  "name" => "flare", 
       :children => [
                     {"name" => "neutro", "size" => Tweet.where(:hashtags.in => [tag], rank_total_lexicon: 1).count},
                     {"name" => "algo negativo", "size" => Tweet.where(:hashtags.in => [tag], rank_total_lexicon: -2).count},
                     {"name" => "negativo", "size" => Tweet.where(:hashtags.in => [tag], rank_total_lexicon: -3).count},
                     {"name" => "muy negativo", "size" => Tweet.where(:hashtags.in => [tag], rank_total_lexicon: -4).count},
                     {"name" => "super negativo", "size" => Tweet.where(:hashtags.in => [tag], rank_total_lexicon: -5).count},
                     {"name" => "algo positivo", "size" => Tweet.where(:hashtags.in => [tag], rank_total_lexicon: 2).count},
                     {"name" => "positivo", "size" => Tweet.where(:hashtags.in => [tag], rank_total_lexicon: 3).count},
                     {"name" => "muy positivo", "size" => Tweet.where(:hashtags.in => [tag], rank_total_lexicon: 4).count},
                     {"name" => "super positivo", "size" => Tweet.where(:hashtags.in => [tag], rank_total_lexicon: 5).count}
                    ]}.to_json
  end
  
  def ling_pipe_tweets_by_tag(tag)
    {  "name" => "flare", 
       :children => [
                     {"name" => "negativo", "size" => Tweet.where(:hashtags.in => [tag], rank_total_ling_pipe: 1).count},
                     {"name" => "positivo", "size" => Tweet.where(:hashtags.in => [tag], rank_total_ling_pipe: 2).count},
                     {"name" => "mixto", "size" => Tweet.where(:hashtags.in => [tag], rank_total_ling_pipe: 3).count},
                     {"name" => "otro", "size" => Tweet.where(:hashtags.in => [tag], rank_total_ling_pipe: 4).count}
                    ]}.to_json
  end
  
end
