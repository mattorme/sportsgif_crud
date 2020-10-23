def run_sql(sql, params = [])
    db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'sportsgif_db'})
    results = db.exec_params(sql, params)
    db.close
    return results
end

def all_gifs
    run_sql("select * from gifs order by id desc;")
end

def find_user_by_email(email)
    results = run_sql("select * from users where email = '#{email}';")
    return results[0]
end

def find_user_by_username(username)
    results = run_sql("select * from users where username = '#{username}';")
    return results[0]
end

def find_user_by_id(id)
    results = run_sql("select * from users where id = '#{id}';")
    return results[0]
end

def find_gif_by_id(id)
    results = run_sql("select * from gifs where id = #{id};")
    return results[0]
end

def recent_gifs(num)
    run_sql("select * from gifs order by id desc limit #{num};")
end