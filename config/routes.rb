Geotwits::Application.routes.draw do
  root 'geo_tweet#index'

  get 'colombian_tweets' => 'geo_tweet#spanish_tweets', as: 'colombian_tweets'
  get 'by_tag/:tag' => 'geo_tweet#by_tag', as: 'by_tag'

end
