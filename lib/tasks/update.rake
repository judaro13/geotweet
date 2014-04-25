namespace :update do
  task clean: :environment do
    
    Stweet.collection.find({"rank_me" => nil}).remove_all
    Tag.delete_all
    Tag.where(lang: "es").delete_all
    
    StweetStat.delete_all
    sstats = StweetStat.new
    
    st = Stweet.all
    puts "*********** Stweet *****************"
    puts st.count
    puts ""
    puts ""
    c=0
    st.each do |t|      
      t.save!
      
      sstats.rank_lexicon[t.rank_total_lexicon.to_s] ||= 0 if t.rank_total_lexicon
      sstats.rank_lexicon[t.rank_total_lexicon.to_s] +=  1 if t.rank_total_lexicon
      
      sstats.rank_me[t.rank_me.to_s] ||= 0 if t.rank_me
      sstats.rank_me[t.rank_me.to_s] +=  1 if t.rank_me
      
      sstats.rank_nlp[t.rank_nlp.to_s] ||= 0 if t.rank_nlp
      sstats.rank_nlp[t.rank_nlp.to_s] +=  1 if t.rank_nlp
      
      sstats.save!
      puts c+=1
    end
#     
    
    st = Tweet.all
    puts "*********** Tweet *****************"
    puts st.count
    puts ""
    puts ""
    puts c = 0
    st.each do |t|
      t.save
      puts c+=1
    end
    
    puts 'done!'
  end
  
  

end