require_relative 'DBConnection.rb'
class Account
  def initialize()
    @dbconnection = DBConnection.new()
  end
  def menu(user_id)
    print "
		Seleccione \n
		1- Ver cuenta \n
    2- Consignar dinero \n"
    $selection = gets
    if $selection.to_i == 1
      return show_account(user_id)
    elsif $selection.to_i == 2
      return add_account(user_id)

    else
      puts "ERROR SELECCIONE UN CAMPO VALIDO"
      menu(user_id)
    end
  end
  def create(user_id)
    time = Time.new
    results=@dbconnection.query("INSERT INTO `mentoria9`.`savings_accounts` (`money`, `user_id`, `created_at`) VALUES ('0', '#{user_id}', '#{time}')")

  end
  def get_account(user_id)
    results=@dbconnection.query("SELECT * FROM savings_accounts where user_id='#{user_id}' ")
    results.each do |row|
      $id_account = row["id"]
    end
    return $id_account
  end
  def get_accountmoney(user_id)
    results=@dbconnection.query("SELECT * FROM savings_accounts where user_id='#{user_id}' ")
    results.each do |row|
      $money = row["money"]
    end
    return $money
  end
  def show_account(user_id)
    results=@dbconnection.query("SELECT * FROM savings_accounts where user_id='#{user_id}' ")
    results.each do |row|
      $money = row["money"]
    end
    puts "Su saldo es "
    print $money

  end
  def add_account(user_id)
    puts "¿cuánto dinero desea ingresar?"
    $saldo = gets.chomp
    $saldo = $saldo.to_i
    results=@dbconnection.query("UPDATE `mentoria9`.`savings_accounts` SET `money`='#{$saldo}' WHERE  user_id='#{user_id}'")


  end

end



