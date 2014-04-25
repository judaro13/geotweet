module ApplicationHelper
  def tsdb_tweets(stweet = nil)
    collection = stweet ? StweetStat : TweetStat
    stats = collection.first
    {  "name" => "flare", 
              :children => [
                 {"name" => "negativo", "size" => stats.ranks["1"]},
                 {"name" => "positivo", "size" => stats.ranks["2"]},
                 {"name" => "mixto",    "size" => stats.ranks["3"]},
                 {"name" => "otro",     "size" => stats.ranks["4"]}
                 ]}.to_json
  end
  
  def lbsa_tweets(stweet = nil)
    collection = stweet ? StweetStat : TweetStat
    stats = collection.first
    {  "name" => "flare", 
              :children => [
                            {"name" => "neutro",         "size" => stats.rank_lexicon["1"]},
                            {"name" => "algo negativo",  "size" => stats.rank_lexicon["-2"]},
                            {"name" => "negativo",       "size" => stats.rank_lexicon["-3"]},
                            {"name" => "muy negativo",   "size" => stats.rank_lexicon["-4"]},
                            {"name" => "super negativo", "size" => stats.rank_lexicon["-5"]},
                            {"name" => "algo positivo",  "size" => stats.rank_lexicon["2"]},
                            {"name" => "positivo",       "size" => stats.rank_lexicon["3"]},
                            {"name" => "muy positivo",   "size" => stats.rank_lexicon["4"]},
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
                          {"name" => "mixto",    "size" => stats.rank_ling_pipe["3"]},
                          {"name" => "otro",     "size" => stats.rank_ling_pipe["4"]}
                        ]}.to_json
  end
  
  def tsdb_tags(stweet = nil)
    collection = stweet ? Stweet : Tweet
    tags_draw = []
    @tags[0..2].each do |tag|
      tag_hash = {}
      tag_hash["Tweet"] = tag.name
      tag_hash["negativo"] = tag.rank[1] if tag.rank[1]
      tag_hash["positivo"] = tag.rank[2] if tag.rank[2]
      tag_hash["mixto"]    = tag.rank[3] if tag.rank[3]
      tag_hash["otro"]     = tag.rank[4] if tag.rank[4]
      tags_draw << tag_hash
    end
    tags_draw.to_json
  end
  
  def lbsa_tags(stweet = nil)
    collection = stweet ? Stweet : Tweet
    top = stweet ? 5 : 2
    tags_draw = []
    
    @tags[0..top].each do |tag|
      tag_hash = {}
      tag_hash["Tweet"] = tag.name
      tag_hash["neutro"] =         tag.rank_lexicon["1"]  if tag.rank_lexicon["1"]
      tag_hash["algo negativo"] =  tag.rank_lexicon["-2"] if tag.rank_lexicon["-2"]
      tag_hash["negativo"] =       tag.rank_lexicon["-3"] if tag.rank_lexicon["-3"]
      tag_hash["muy negativo"] =   tag.rank_lexicon["-4"] if tag.rank_lexicon["-4"]
      tag_hash["super negativo"] = tag.rank_lexicon["-5"] if tag.rank_lexicon["-5"]
      tag_hash["algo positivo"] =  tag.rank_lexicon["2"]  if tag.rank_lexicon["2"]
      tag_hash["positivo"] =       tag.rank_lexicon["3"]  if tag.rank_lexicon["3"]
      tag_hash["muy positivo"] =   tag.rank_lexicon["4"]  if tag.rank_lexicon["4"]
      tag_hash["super positivo"] = tag.rank_lexicon["5"]  if tag.rank_lexicon["5"]
      tags_draw << tag_hash
    end
    tags_draw.to_json
  end
  
  def ling_pipe_tags(stweet = nil)
    collection = stweet ? Stweet : Tweet
    tags_draw = []
    @tags[0..2].each do |tag|
      tag_hash = {}
      tag_hash["Tweet"] =    tag.name
      tag_hash["negativo"] = tag.rank_ling_pipe[1] if tag.rank_ling_pipe[1]
      tag_hash["positivo"] = tag.rank_ling_pipe[2] if tag.rank_ling_pipe[2]
      tag_hash["mixto"] =    tag.rank_ling_pipe[3] if tag.rank_ling_pipe[3]
      tag_hash["otro"] =     tag.rank_ling_pipe[4] if tag.rank_ling_pipe[4]
      tags_draw << tag_hash
    end
    tags_draw.to_json
  end
  
  def tsdb_tweets_by_tag(tag, stweet = nil)
    collection = Tag.where(name: tag).first
    
    {  "name" => "flare", 
       :children => [
                     {"name" => "negativo", "size" => collection.rank[1]},
                     {"name" => "positivo", "size" => collection.rank[2]},
                     {"name" => "mixto",    "size" => collection.rank[3]},
                     {"name" => "otro",     "size" => collection.rank[4]}
                    ]}.to_json
  end
  
  def lbsa_tweets_by_tag(tag, stweet = nil)
    collection = Tag.where(name: tag).first
    
    {  "name" => "flare", 
       :children => [
                     {"name" => "neutro",         "size" => collection.rank_lexicon[ 1 ]},
                     {"name" => "algo negativo",  "size" => collection.rank_lexicon[ -2 ]},
                     {"name" => "negativo",       "size" => collection.rank_lexicon[ -3 ]},
                     {"name" => "muy negativo",   "size" => collection.rank_lexicon[ -4 ]},
                     {"name" => "super negativo", "size" => collection.rank_lexicon[ -5 ]},
                     {"name" => "algo positivo",  "size" => collection.rank_lexicon[ 2 ]},
                     {"name" => "positivo",       "size" => collection.rank_lexicon[ 3 ]},
                     {"name" => "muy positivo",   "size" => collection.rank_lexicon[ 4 ]},
                     {"name" => "super positivo", "size" => collection.rank_lexicon[ 5 ]}
                    ]}.to_json
  end
  
  def ling_pipe_tweets_by_tag(tag, stweet = nil)
    collection = Tag.where(name: tag).first
    
    {  "name" => "flare", 
       :children => [
                     {"name" => "negativo", "size" => collection.rank_ling_pipe[1]},
                     {"name" => "positivo", "size" => collection.rank_ling_pipe[2]},
                     {"name" => "mixto",    "size" => collection.rank_ling_pipe[3]},
                     {"name" => "otro",     "size" => collection.rank_ling_pipe[4]}
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
