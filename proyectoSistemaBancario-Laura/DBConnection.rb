require 'mysql2'

class DBConnection

  attr_reader :clientgi

  def initialize
    @client = Mysql2::Client.new(
        host:'localhost',
        username:'root',
        password:'',
        port:'3306',
        database:'mentoria9'
    )
  end
  def query(query)
    @client.query(query, cast_booleans: true)
  end

  def close_connection
    @client.close
  end
end
