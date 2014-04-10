module ApplicationHelper
  def tsdb_tweets(stweet = nil)
    collection = stweet ? StweetStat : TweetStat
    stats = collection.first
    {  "name" => "flare", 
              :children => [
                 {"name" => "negativo", "size" => stats.ranks["1"]},
                 {"name" => "positivo", "size" => stats.ranks["2"]},
                 {"name" => "mixto", "size" => stats.ranks["3"]},
                 {"name" => "otro", "size" => stats.ranks["4"]}
                 ]}.to_json
  end
  
  def lbsa_tweets(stweet = nil)
    collection = stweet ? StweetStat : TweetStat
    stats = collection.first
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
  
  def ling_pipe_tweets(stweet = nil)
    collection = stweet ? StweetStat : TweetStat
    stats = collection.first
    {  "name" => "flare", 
              :children => [
                          {"name" => "negativo", "size" => stats.rank_ling_pipe["1"]},
                          {"name" => "positivo", "size" => stats.rank_ling_pipe["2"]},
                          {"name" => "mixto", "size" => stats.rank_ling_pipe["3"]},
                          {"name" => "otro", "size" => stats.rank_ling_pipe["4"]}
                        ]}.to_json
  end
  
  def tsdb_tags(stweet = nil)
    collection = stweet ? Stweet : Tweet
    tags_draw = []
    tags = @tags.map{|t| t.name}
    tags[0..2].each do |t|
      tag_hash = {}
      tag_hash["Tweet"] = t
      tag_hash["negativo"] = collection.where(:hashtags.in => [t], :rank => 1).count
      tag_hash["positivo"] = collection.where(:hashtags.in => [t], :rank => 2).count
      tag_hash["mixto"] = collection.where(:hashtags.in => [t], :rank => 3).count
      tag_hash["otro"] = collection.where(:hashtags.in => [t], :rank => 4).count
      tags_draw << tag_hash
    end
    tags_draw.to_json
  end
  
  def lbsa_tags(stweet = nil)
    collection = stweet ? Stweet : Tweet
    top = stweet ? 5 : 2
    tags_draw = []
    tags = @tags.map{|t| t.name}
    tags[0..top].each do |t|
      tag_hash = {}
      tag_hash["Tweet"] = t
      tag_hash["neutro"] = collection.where(:hashtags.in => [t], :rank_total_lexicon => 1).count
      tag_hash["algo negativo"] = collection.where(:hashtags.in => [t], :rank_total_lexicon => -2).count
      tag_hash["negativo"] = collection.where(:hashtags.in => [t], :rank_total_lexicon => -3).count
      tag_hash["muy negativo"] = collection.where(:hashtags.in => [t], :rank_total_lexicon => -4).count
      tag_hash["super negativo"] = collection.where(:hashtags.in => [t], :rank_total_lexicon => -4).count
      tag_hash["algo positivo"] = collection.where(:hashtags.in => [t], :rank_total_lexicon => 2).count
      tag_hash["positivo"] = collection.where(:hashtags.in => [t], :rank_total_lexicon => 3).count
      tag_hash["muy positivo"] = collection.where(:hashtags.in => [t], :rank_total_lexicon => 4).count
      tag_hash["super positivo"] = collection.where(:hashtags.in => [t], :rank_total_lexicon => 5).count
      tags_draw << tag_hash
    end
    tags_draw.to_json
  end
  
  def ling_pipe_tags(stweet = nil)
    collection = stweet ? Stweet : Tweet
    tags_draw = []
    tags = @tags.map{|t| t.name}
    tags[0..2].each do |t|
      tag_hash = {}
      tag_hash["Tweet"] = t
      tag_hash["negativo"] = collection.where(:hashtags.in => [t], :rank_total_ling_pipe => 1).count
      tag_hash["positivo"] = collection.where(:hashtags.in => [t], :rank_total_ling_pipe => 2).count
      tag_hash["mixto"] = collection.where(:hashtags.in => [t], :rank_total_ling_pipe => 3).count
      tag_hash["otro"] = collection.where(:hashtags.in => [t], :rank_total_ling_pipe => 4).count
      tags_draw << tag_hash
    end
    tags_draw.to_json
  end
  
  def tsdb_tweets_by_tag(tag, stweet = nil)
    collection = stweet ? Stweet : Tweet
    {  "name" => "flare", 
       :children => [
                     {"name" => "negativo", "size" => collection.where(:hashtags.in => [tag], rank: 1).count},
                     {"name" => "positivo", "size" => collection.where(:hashtags.in => [tag], rank: 2).count},
                     {"name" => "mixto", "size" => collection.where(:hashtags.in => [tag], rank: 3).count},
                     {"name" => "otro", "size" => collection.where(:hashtags.in => [tag], rank: 4).count}
                    ]}.to_json
  end
  
  def lbsa_tweets_by_tag(tag, stweet = nil)
    collection = stweet ? Stweet : Tweet
    {  "name" => "flare", 
       :children => [
                     {"name" => "neutro", "size" => collection.where(:hashtags.in => [tag], rank_total_lexicon: 1).count},
                     {"name" => "algo negativo", "size" => collection.where(:hashtags.in => [tag], rank_total_lexicon: -2).count},
                     {"name" => "negativo", "size" => collection.where(:hashtags.in => [tag], rank_total_lexicon: -3).count},
                     {"name" => "muy negativo", "size" => collection.where(:hashtags.in => [tag], rank_total_lexicon: -4).count},
                     {"name" => "super negativo", "size" => collection.where(:hashtags.in => [tag], rank_total_lexicon: -5).count},
                     {"name" => "algo positivo", "size" => collection.where(:hashtags.in => [tag], rank_total_lexicon: 2).count},
                     {"name" => "positivo", "size" => collection.where(:hashtags.in => [tag], rank_total_lexicon: 3).count},
                     {"name" => "muy positivo", "size" => collection.where(:hashtags.in => [tag], rank_total_lexicon: 4).count},
                     {"name" => "super positivo", "size" => collection.where(:hashtags.in => [tag], rank_total_lexicon: 5).count}
                    ]}.to_json
  end
  
  def ling_pipe_tweets_by_tag(tag, stweet = nil)
    collection = stweet ? Stweet : Tweet
    {  "name" => "flare", 
       :children => [
                     {"name" => "negativo", "size" => collection.where(:hashtags.in => [tag], rank_total_ling_pipe: 1).count},
                     {"name" => "positivo", "size" => collection.where(:hashtags.in => [tag], rank_total_ling_pipe: 2).count},
                     {"name" => "mixto", "size" => collection.where(:hashtags.in => [tag], rank_total_ling_pipe: 3).count},
                     {"name" => "otro", "size" => collection.where(:hashtags.in => [tag], rank_total_ling_pipe: 4).count}
                    ]}.to_json
  end
  
  
  def rank_span(value)
    html = '<span class="label label-default"> neutro</span> '
    case value
    when 1
      html = '<span class="label label-danger"> negativo</span> '
    when 2
      html = '<span class="label label-success"> positivo</span> '
    when 3
      html = '<span class="label label-primary"> mixto</span> '
    end
    html
  end
  
  def lbsa_span(value)
    html = html = '<span class="label label-default"> neutro </span> '
    case value
    when 1
      html = '<span class="label label-default"> neutro </span> '
    when 2
      html = '<span class="label label-info">  algo positivo </span> '
    when 3
      html = '<span class="label label-success"> positivo </span> '
    when 4
      html = '<span class="label label-success"> muy positivo </span> '
    when 5
      html = '<span class="label label-success"> super positivo </span> '
    when -2
      html = '<span class="label label-info">  algo negativo </span> '
    when -3
      html = '<span class="label label-warning"> negativo </span> '
    when -4
      html = '<span class="label label-danger"> muy negativo </span> '
    when -5
      html = '<span class="label label-danger"> super negativo </span> '
    end
    html
  end
end
