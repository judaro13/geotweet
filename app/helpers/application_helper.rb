module ApplicationHelper
  def tsdb_tweets
    Tweet.where(rank: 1).count
  end
end
