     
require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'bcrypt'

def run_sql(sql)
  PG.connect(ENV['DATABASE_URL'] || {dbname: 'sportsgif_db'})
  results = db.exec(sql)
  db.close
  return results
end

get '/' do
  erb :index
end





