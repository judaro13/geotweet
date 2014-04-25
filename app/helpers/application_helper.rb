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
    if stweet
      vals = {  "name" => "flare", 
                :children => [
                      {"name" => "positivo", "size" => stats.rank_lexicon["1"]},
                      {"name" => "negativo", "size" => stats.rank_lexicon["-1"]}
                  ]}
    else
      vals = {  "name" => "flare", 
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
                        ]}
    end
    vals.to_json
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
      tag_hash["negativo"] = tag.rank["1"] if tag.rank["1"]
      tag_hash["positivo"] = tag.rank["2"] if tag.rank["2"]
      tag_hash["mixto"]    = tag.rank["3"] if tag.rank["3"]
      tag_hash["otro"]     = tag.rank["4"] if tag.rank["4"]
      tags_draw << tag_hash
    end
    tags_draw.to_json
  end
  
  def lbsa_tags(stweet = nil)
    collection = stweet ? Stweet : Tweet
    top = stweet ? 5 : 2
    tags_draw = []
    
    @tags[0..top].each do |tag|
      next if tag.rank_lexicon.empty?
      tag_hash = {}
      tag_hash["Tweet"] = tag.name
      if stweet 
        tag_hash["positivo"] = tag.rank_lexicon["1"]  if tag.rank_lexicon["1"]
        tag_hash["negativo"] = tag.rank_lexicon["-1"] if tag.rank_lexicon["-1"]
      else
        tag_hash["neutro"] =         tag.rank_lexicon["1"]  if tag.rank_lexicon["1"]
        tag_hash["algo negativo"] =  tag.rank_lexicon["-2"] if tag.rank_lexicon["-2"]
        tag_hash["negativo"] =       tag.rank_lexicon["-3"] if tag.rank_lexicon["-3"]
        tag_hash["muy negativo"] =   tag.rank_lexicon["-4"] if tag.rank_lexicon["-4"]
        tag_hash["super negativo"] = tag.rank_lexicon["-5"] if tag.rank_lexicon["-5"]
        tag_hash["algo positivo"] =  tag.rank_lexicon["2"]  if tag.rank_lexicon["2"]
        tag_hash["positivo"] =       tag.rank_lexicon["3"]  if tag.rank_lexicon["3"]
        tag_hash["muy positivo"] =   tag.rank_lexicon["4"]  if tag.rank_lexicon["4"]
        tag_hash["super positivo"] = tag.rank_lexicon["5"]  if tag.rank_lexicon["5"]
      end
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
      tag_hash["negativo"] = tag.rank_ling_pipe["1"] if tag.rank_ling_pipe["1"]
      tag_hash["positivo"] = tag.rank_ling_pipe["2"] if tag.rank_ling_pipe["2"]
      tag_hash["mixto"] =    tag.rank_ling_pipe["3"] if tag.rank_ling_pipe["3"]
      tag_hash["otro"] =     tag.rank_ling_pipe["4"] if tag.rank_ling_pipe["4"]
      tags_draw << tag_hash
    end
    tags_draw.to_json
  end
  
  def tsdb_tweets_by_tag(tag, stweet = nil)
    collection = Tag.where(name: tag).first
    {  "name" => "flare", 
       :children => [
                     {"name" => "negativo", "size" => collection.rank["1"]},
                     {"name" => "positivo", "size" => collection.rank["2"]},
                     {"name" => "mixto",    "size" => collection.rank["3"]},
                     {"name" => "otro",     "size" => collection.rank["4"]}
                    ]}.to_json
  end
  
  def lbsa_tweets_by_tag(tag, stweet = nil)
    collection = Tag.where(name: tag).first
    hash = {}
    
    if stweet 
      hash = {"name" => "flare", 
              :children => [
                            {"name" => "positivo",         "size" => collection.rank_lexicon[ "1" ]},
                            {"name" => "negativo",         "size" => collection.rank_lexicon[ "-1" ]}
                           ]}
    else
      hash = {"name" => "flare", 
              :children => [
                    {"name" => "neutro",         "size" => collection.rank_lexicon[ "1" ]},
                    {"name" => "algo negativo",  "size" => collection.rank_lexicon[ "-2" ]},
                    {"name" => "negativo",       "size" => collection.rank_lexicon[ "-3" ]},
                    {"name" => "muy negativo",   "size" => collection.rank_lexicon[ "-4" ]},
                    {"name" => "super negativo", "size" => collection.rank_lexicon[ "-5" ]},
                    {"name" => "algo positivo",  "size" => collection.rank_lexicon[ "2" ]},
                    {"name" => "positivo",       "size" => collection.rank_lexicon[ "3" ]},
                    {"name" => "muy positivo",   "size" => collection.rank_lexicon[ "4" ]},
                    {"name" => "super positivo", "size" => collection.rank_lexicon[ "5" ]}
                    ]}
    end
    hash.to_json
  end
  
  def ling_pipe_tweets_by_tag(tag, stweet = nil)
    collection = Tag.where(name: tag).first
    {  "name" => "flare", 
       :children => [
                     {"name" => "negativo", "size" => collection.rank_ling_pipe["1"]},
                     {"name" => "positivo", "size" => collection.rank_ling_pipe["2"]},
                     {"name" => "mixto",    "size" => collection.rank_ling_pipe["3"]},
                     {"name" => "otro",     "size" => collection.rank_ling_pipe["4"]}
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
  
  def tweets_for_spider(tweets)
    values = [[],[],[]]
    
    total = tweets.count
    percentaje = 1.0/total
    
    if tweets.first.class == Stweet
      
      #lexicografico
      lpos = {axis: "Positivo", value: 0}
      lneg = {axis: "Negativo", value: 0}
      lneu = {axis: "Neutro", value: 0}
      
      #nlp
      nppos = {axis: "Positivo", value: 0}
      npneg = {axis: "Negativo", value: 0}
      npneu = {axis: "Neutro", value: 0}
      
      #me
      mpos = {axis: "Positivo", value: 0}
      mneg = {axis: "Negativo", value: 0}
      mneu = {axis: "Neutro", value: 0}

      tweets.each do |t|
        #lexicografico
        if t.rank_total_lexicon == 1
          lpos[:value]+=percentaje
        else
          lneg[:value]+=percentaje
        end
        
        #nlp
        if t.rank_nlp_score
          if t.rank_nlp_score > 0
            nppos[:value]+=percentaje
          elsif t.rank_nlp_score == 0
            npneu[:value]+=percentaje
          else
            npneg[:value]+=percentaje
          end
        end
        
        #me
        if t.rank_me == 0 
          mneg[:value]+=percentaje
        elsif t.rank_me == 2
          mneu[:value]+=percentaje
        else
          mpos[:value]+=percentaje
        end
      end
      
      #lexico
      values.first << lpos 
      values.first << lneg
      values.first << lneu
      
      #nlp
      values.second << nppos
      values.second << npneg
      values.second << npneu
      
      #me
      values.last << mpos
      values.last << mneg
      values.last << mneu
      
      @labels =["Lexicon-Based Sentiment Analysis","Natural Languague Procesator","Máxima Entropia"]
    else
      #lexicografico
      lneu = {axis: "Neutro", value: 0}
      lapos = {axis: "Algo Positivo", value: 0}
      lpos = {axis: "Positivo", value: 0}
      lmpos = {axis: "Muy Positivo", value: 0}
      lspos = {axis: "Superpositivo", value: 0}
      laneg = {axis: "Algo Negativo", value: 0}
      lneg = {axis: "Negativo", value: 0}
      lmneg = {axis: "Muy Negativo", value: 0}
      lsneg = {axis: "Supernegativo", value: 0}
      
      #lingpipe
      lpneg = {axis: "Negativo", value: 0}
      lppos = {axis: "Positivo", value: 0}
      lpmix = {axis: "Mixto", value: 0}
      lpotr = {axis: "Otro", value: 0}
      
      #rank
      rneg = {axis: "Negativo", value: 0}
      rpos = {axis: "Positivo", value: 0}
      rmix = {axis: "Mixto", value: 0}
      rotr = {axis: "Otro", value: 0}
      
      tweets.each do |t|
        #lexicografico
        if t.rank_total_lexicon == 1
          lneu[:value]+=percentaje
        elsif t.rank_total_lexicon == 2
          lapos[:value]+=percentaje
        elsif t.rank_total_lexicon == 3
          lpos[:value]+=percentaje
        elsif t.rank_total_lexicon == 4
          lmpos[:value]+=percentaje
        elsif t.rank_total_lexicon == 5
          lspos[:value]+=percentaje
        elsif t.rank_total_lexicon == -2
          laneg[:value]+=percentaje
        elsif t.rank_total_lexicon == -3
          lneg[:value]+=percentaje
        elsif t.rank_total_lexicon == -4
          lmneg[:value]+=percentaje
        else
          lsneg[:value]+=percentaje
        end
        
        #lingpipe
        if t.rank_total_ling_pipe == 1
          lpneg[:value]+=percentaje
        elsif t.rank_total_ling_pipe == 2
          lppos[:value]+=percentaje
        elsif t.rank_total_ling_pipe == 3
          lpmix[:value]+=percentaje
        else
          lpotr[:value]+=percentaje
        end
        
        #rank
        if t.rank == 1
          rneg[:value]+=percentaje
        elsif t.rank == 2
          rpos[:value]+=percentaje
        elsif t.rank == 3
          rmix[:value]+=percentaje
        else
          rotr[:value]+=percentaje
        end
      end
      
      values.first << lneu
      values.first << lapos
      values.first << lpos
      values.first << lmpos
      values.first << lspos
      values.first << laneg
      values.first << lneg
      values.first << lmneg
      values.first << lsneg
      
      #lingpipe
      values.second << lpneg
      values.second << lppos
      values.second << lpmix
      values.second << lpotr
      
      #rank
      values.last << rneg
      values.last << rpos
      values.last << rmix
      values.last << rotr
      @labels =["Lexicon-Based Sentiment Analysis","Ling Pipe","Twitter Sentiment Dataset 2008 Debates"]
    end
    values
  end
  
end     