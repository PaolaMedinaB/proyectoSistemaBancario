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
  def query(test)
    results = @client.query(test)
    return  results
  end
end
