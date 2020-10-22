     
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'bcrypt'
require_relative 'db/data_access'
also_reload 'db/data_access'

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
  erb :index, locals: { gifs: gifs }
end

get '/gifs/new' do
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
  user = find_user_by_email(params['email'])
  if BCrypt::Password.new(user['password_digest']) == params['password']
    session[:user_id] = user['id']
    redirect "/"
  else 
    erb :login
  end
end