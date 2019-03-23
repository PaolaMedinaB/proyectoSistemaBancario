require_relative 'DBConnection.rb'
require_relative 'accounts.rb'
class Mattress
  def initialize()
    @dbconnection = DBConnection.new()
    @id_account = Account.new()
  end
  def menu(user_id)
    print "
		Seleccione \n
		1- Ver Colchón \n
    2- Agregar al Colchón \n"
    $selection = gets
    if $selection.to_i == 1
      show_account(user_id)
    elsif $selection.to_i == 2
      add_account(user_id)
    else
      puts "ERROR SELECCIONE UN CAMPO VALIDO"
      menu(user_id)
    end
  end

  def add_account(user_id)
    puts "¿cuánto dinero desea ingresar?"
    $money_pokets = gets.chomp
    $money_pokets = $money_pokets.to_i
    account_idS= @id_account.get_account(user_id)
    account_moneyS= @id_account.get_accountmoney(user_id)
    new_account_moneyS = account_moneyS - $money_pokets
    if new_account_moneyS > 0
      money_mattress = get_mattress_id(user_id)
      money_mattress = money_mattress + $money_pokets
      time = Time.new
      results=@dbconnection.query("UPDATE `mentoria9`.`mattress` SET `money`=  '#{money_mattress}' WHERE account_id = #{account_idS}")
      result_money=@dbconnection.query("UPDATE `mentoria9`.`savings_accounts` SET `money`='#{new_account_moneyS}' WHERE  `id`=#{account_idS}")
    else
      puts "pailas prro sul saldo es"
      print account_moneyS

    end
    menu(user_id)
  end

  def show_account(user_id)
    account_idS= @id_account.get_account(user_id)
    results=@dbconnection.query("SELECT * FROM mattress where account_id='#{account_idS}' ")
    results.each do |row|
      print row["name"]
      print " "
      print row["money"]
      puts " "
    end
    menu(user_id)
  end
  def get_mattress_id(user_id)
    account_idS= @id_account.get_account(user_id)
    results=@dbconnection.query("SELECT * FROM mattress where account_id='#{account_idS}' ")
    results.each do |row|
      $money_mattress =row["money"]
    end
    return $money_mattress
  end
  def create(user_id)
    time = Time.new
    account_idS= @id_account.get_account(user_id)
    results=@dbconnection.query("INSERT INTO `mentoria9`.`mattress` (`name`, `account_id`, `money`, `updated_at`) VALUES ('colchon', '#{account_idS}', '0', '#{time}')")
  end
end
#init
