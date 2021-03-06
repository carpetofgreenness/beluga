require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models"
require "faker"
require "date"

set :database, "sqlite3:beluga_db.sqlite3"
enable :sessions



get '/' do
  # session[:user_id] = 5
  @users = User.all
  @posts = Post.all
  @home = "active"
  @tags = ""
  @profile = ""
  @signup = ""
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
  @home = ""
  @tags = ""
  @profile = ""
  @signup = ""
  @post = Post.find(params[:id])
  @posts = [@post]
  erb :post
end

get '/post/edit/:id' do
  @home = ""
  @tags = ""
  @profile = ""
  @signup = ""
  @post = Post.find(params[:id])
  erb :edit_post
end

post "/post/edit/:id" do
  @post = Post.find(params[:id])
  @post.update_attributes(url: params[:url], title: params[:title], body: params[:body], tag_id: params[:tag])
  redirect "/post/#{@post.id}"
end

get '/profile/:id' do
  @home = ""
  @tags = ""
  @profile = "active"
  @signup = ""
  @user = User.find(params[:id])
  @posts = @user.posts
  erb :profile
end

get "/sign-out" do
  @home = ""
  @tags = ""
  @profile = ""
  @signup = ""
  session.clear
  flash[:notice] = "You've successfully signed out!"
  redirect "/"
end

get "/edit-profile/:id" do
  @home = ""
  @tags = ""
  @profile = ""
  @signup = ""
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
  @home = ""
  @tags = ""
  @profile = ""
  @signup = ""
  @users = User.all
  erb :users
end

get "/user/new" do
  @home = ""
  @tags = ""
  @profile = ""
  @signup = "active"
   erb :user
end

post "/user/new" do
  @home = ""
  @tags = ""
  @profile = ""
  @signup = ""
  @user = User.create(username: params[:username], email: params[:email], password: params[:password], description: params[:description], pic: params[:pic])
  redirect "/profile/#{@user.id}"
end

post "/user/:id/delete" do
  User.find(params[:id]).destroy
  session.clear
  redirect "/"
end

get "/comment/:id" do
  @home = ""
  @tags = ""
  @profile = ""
  @signup = ""
  @comment = Comment.find(params[:id])
  @user = @comment.user
  @post = @comment.post
  erb :comment
end

get "/tag/new" do
  @home = ""
  @tags = ""
  @profile = ""
  @signup = ""
  erb :tag_new
end

post "/tag/new" do
  @tag = Tag.create(name: params[:name])
  redirect "/tag/#{@tag.id}"
end

get "/tag/:id" do
  @home = ""
  @tags = ""
  @profile = ""
  @signup = ""
  @tag = Tag.find(params[:id])
  @posts = @tag.posts
  erb :tag
end

post "/comment/:post_id/:user_id/new" do
  @comment = Comment.create()
  @comment = Comment.create(body: params[:body], user_id: params[:user_id], post_id: params[:post_id])
  redirect "/post/#{params[:post_id]}"
end

get "/tag/:id/edit" do
  @home = ""
  @tags = ""
  @profile = ""
  @signup = ""
  @tag = Tag.find(params[:id])
  erb :tag_edit
end

post "/tag/:id/edit" do
  @tag = Tag.find(params[:id])
  @tag.update(name: params[:name])
  redirect "/tag/#{@tag.id}"
end

#david's section

post "/post/:id/delete" do
  post = Post.find(params[:id])
  @user_id = post.user_id
  post.destroy
  redirect "/profile/#{@user_id}"
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
  @home = ""
  @tags = ""
  @profile = ""
  @signup = ""
  @comment = Comment.find(params[:comment_id])
  @post = @comment.post
  erb :comment_edit
end


get '/tags/' do
  @home = ""
  @tags = "active"
  @profile = ""
  @signup = ""
  erb :tags
end

def current_user
  User.find(session[:user_id]) if session[:user_id]
end





# david's section