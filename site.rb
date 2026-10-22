require "sqlite3"
require "sinatra"
require "sinatra/cookies"


#sql  	


db = SQLite3::Database.new("db.db")

db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS
    blog ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        time DATETIME DEFAULT CURRENT_TIME
);
SQL


get '/' do
	@admin =  cookies[:admin]
	@updates = db.execute('SELECT * FROM blog')  
	erb:index
	
end


get '/login/:password' do
   if params['password'] == "1234!"
   		 cookies[:admin] = 'true'
   end
   redirect ('/')
end



get '/home' do
   cookies[:admin] = 'false'
   redirect ('/')
end


post '/new' do
  db.execute"
      INSERT INTO
      blog (title, content)
      VALUES (?,?)", ["#{params['title']}", "#{params['content']}"]
  redirect ('/')
end
post '/edit' do
  db.execute"
      UPDATE INTO
      blog (title, content)
      VALUES (?,?)", ["#{params['title']}", "#{params['content']}"]
  redirect ('/')
end
post '/delete' do
  db.execute"
      DELETE FROM
      blog WHERE id = ?;", ["#{params['id']}"]
  redirect ('/')
end


