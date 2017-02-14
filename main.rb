require "sinatra"
require "sinatra/activerecord"
require "sinatra/flash"
require "./models"
require "faker"

set :database, "sqlite3:test.sqlite3"
enable :sessions

