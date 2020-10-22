     
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'bcrypt'
require_relative 'db/data_access'
also_reload 'db/data_access' if development?

enable :sessions

def logged_in?()
  if session[:user_id]
    true
  else
    false
  end
end

def current_user()
  find_user_by_id(session[:user_id])
end


get '/' do
  gifs = all_gifs()
  # username = find_user_by_username()
  erb :index, locals: { gifs: gifs}
end

get '/gifs/new' do
  redirect '/login' unless logged_in?
  erb :new
end


post '/gifs' do
  sql = "insert into gifs (description, gif_url, sport, athlete) values ('#{params["description"]}', '#{params["gif_url"]}', '#{params["sport"]}', '#{params["athlete"]}');"
  run_sql(sql)
  redirect "/"
end

get '/login' do
  erb :login
end

post '/login' do 
  user = find_user_by_username(params['username'])
  if BCrypt::Password.new(user['password_digest']) == params['password']
    session[:user_id] = user['id']
    redirect "/"
  else 
    erb :login
  end
end

delete '/logout' do
  session[:user_id] = nil
  redirect '/'
end

get '/signup' do
  erb :signup
end

post '/signup' do
  password_digest = BCrypt::Password.create(params["password"])
  run_sql("INSERT INTO users (email, username, password_digest) VALUES ('#{params["email"]}', '#{params["username"]}', '#{password_digest}');")
  redirect "/"
end

