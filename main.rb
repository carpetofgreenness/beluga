require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models"
require "faker"

set :database, "sqlite3:test.sqlite3"
enable :sessions

get '/' do
  @users = User.all
  @posts = Post.all
  erb :index
end

post '/sign-in' do
  @user = User.where(username: params[:username]).first
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id
    redirect "/profile/#{@user.id}"
  else
    flash[:notice] = "Sorry, your login didn't work. Try again"
    redirect '/'
  end
end

get '/profile/:id' do
  @user = User.find(params[:id])
  erb :profile
end

get "/sign-out" do
  session.clear
  flash[:notice] = "You've successfully signed out!"
  redirect "/"
end