require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models"
require "faker"

set :database, "sqlite3:beluga_db.sqlite3"
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

post '/post/new' do
  @user = User.find(session[:user_id])
  Post.create(user_id: @user.id, tag_id: params[:tag], url: params[:url], title: params[:title], body: params[:body])
  redirect "/profile/#{@user.id}"
end

get '/post/:id' do
  @post = Post.find(params[:id])
  erb :post
end

get '/post/edit/:id' do
  @post = Post.find(params[:id])
  erb :edit_post
end

post "/post/edit/:id" do
  @post = Post.find(params[:id])
  @post.update_attributes(url: params[:url], title: params[:title], body: params[:body], tag_id: params[:tag])
  redirect "/post/#{@post.id}"
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

get "/edit-profile/:id" do
  @user = User.find(session[:user_id])
  erb :edit_profile
end

post "/edit-profile/:id" do
  @user = User.find(session[:user_id])
  @user.update_attributes(username: params[:username], email: params[:email], password: params[:password], description: params[:description], pic: params[:pic])
  redirect "/"
end



# hannah's section

get "/users" do
  @users = User.all
  erb :users
end

get "/user/new" do
   erb :user
end

post "/user/new" do
  @user = User.create(username: params[:username], email: params[:email], password: params[:password], description: params[:description], pic: params[:pic])
  redirect "/profile/#{@user.id}"
end

post "/user/:id/delete" do
  User.find(params[:id]).destroy
  session.clear
  redirect "/"
end


#david's section

post "/post/:id/delete" do
  post = Post.find(params[:id])
  @user_id = post.user_id
  post.destroy
  redirect "/profile/#{@user_id}"
end

















# david's section