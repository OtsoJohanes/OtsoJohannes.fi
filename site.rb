require 'sinatra'
require "sqlite3"

get '/' do
  erb :index
end

db = SQLite3::Database.new("db.db")

db.execute <<-SQL
    CREATE TABLE IF NOT EXISTS
    hmm ( 
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        content TEXT NOT NULL,
        public BOOLEAN,
        time DATETIME DEFAULT CURRENT_TIME
);
SQL

post "/hmm" do 
  db.execute("INSERT INTO hmm(
   title, content, public, id) (?, ?, ?,)",
    params["title"],
    params["content"],
    params["public"]
    )

  redirect "/"

end
