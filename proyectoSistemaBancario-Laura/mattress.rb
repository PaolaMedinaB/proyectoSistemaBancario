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
    2- Agregar al Colchón \n
    3- Retirar Dinero de colchón \n"
    $selection = gets.chomp
    if $selection.to_i == 1
      show_account(user_id)
    elsif $selection.to_i == 2
      add_account(user_id)
    elsif $selection.to_i == 3
      remove_money(user_id)
    else
      puts "ERROR SELECCIONE UN CAMPO VALIDO"
      menu(user_id)
    end
  end

  def add_account(user_id)
    puts "¿Cuánto dinero desea ingresar?"
    $money_pokets = gets.chomp
    if ($money_pokets < 0)
      puts "Debe ingresar un valor mínimo de $1"
    else
    $money_pokets = $money_pokets.to_i
    account_idS= @id_account.get_account(user_id)
    account_moneyS= @id_account.get_accountmoney(user_id)
    new_account_moneyS = account_moneyS - $money_pokets
  end
    if new_account_moneyS > 0
      money_mattress = get_mattress_id(user_id)
      money_mattress = money_mattress + $money_pokets
      time = Time.new
      results=@dbconnection.query("UPDATE `mentoria9`.`mattress` SET `money`=  '#{money_mattress}' WHERE account_id = #{account_idS}")
      result_money=@dbconnection.query("UPDATE `mentoria9`.`savings_accounts` SET `money`='#{new_account_moneyS}' WHERE  `id`=#{account_idS}")
      puts "Transacción exitosa"
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

  def remove_money(user_id)
    puts "¿Cuánto dinero desea retirar?"
    $saldo = gets.chomp
    $money_start=get_mattress_id(user_id)
    if ($saldo < 0 && $money_start < $saldo)
      puts "No se puede realizar la transacción, ingrese un valor válido"
    else
    $saldo = $saldo.to_i
    $retire_saldo = $saldo.to_i
    $saldo = $money_start - $saldo
    account_idS= @id_account.get_account(user_id)
    results=@dbconnection.query("UPDATE `mentoria9`.`mattress` SET `money`=  '#{$saldo}' WHERE account_id = #{account_idS}")
    @id_account.setadd_account(user_id,$retire_saldo)
  end
  puts "Transacción exitosa"
  end
end
#init
