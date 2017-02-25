class TweetsController < ApplicationController

  get '/tweets' do
      @tweets = Tweet.all
      erb :'tweets/tweets'   
  end

  get '/tweets/new' do
      erb :'tweets/create_tweet'
  end

  post '/tweets' do
      user = User.find_by_id(session[:user_id])
      @tweet = Tweet.create(:content => params[:content], :user_id => user.id)
      redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do 
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    
  end

  get '/tweets/:id/edit' do
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet.user_id == session[:user_id]
       erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
  end

  patch '/tweets/:id' do 
      @tweet = Tweet.find_by_id(params[:id])
      @tweet.content = params[:content]
      @tweet.save
      redirect to "/tweets/#{@tweet.id}"
    
  end

  delete '/tweets/:id/delete' do 
      @tweet = Tweet.find_by_id(params[:id])
        @tweet.delete
        redirect to '/tweets'
  end

end