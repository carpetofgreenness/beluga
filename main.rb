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

get "/comment/:id" do
  @comment = Comment.find(params[:id])
  @user = @comment.user
  @post = @comment.post
  erb :comment
end

post "/comment/:post_id/:user_id/new" do
  @comment = Comment.create(body: params[:body], user_id: params[:user_id], post_id: params[:post_id])
  redirect "/post/#{params[:post_id]}"
end

post "/comment/:id/delete" do
  Comment.find(params[:id]).destroy
  redirect back
end

post "/comment/:id/edit" do
  Comment.find(params[:id]).update(body: params[:body])
  @post_id=Comment.find(params[:id]).post.id
  redirect "/post/#{@post_id}"
end

get "/comment/:comment_id/edit" do
  @comment = Comment.find(params[:comment_id])
  @post = @comment.post
  erb :comment_edit
end








# david's section