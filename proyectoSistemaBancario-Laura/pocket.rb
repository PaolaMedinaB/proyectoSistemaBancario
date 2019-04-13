require_relative 'DBConnection.rb'
require_relative 'accounts.rb'
class Pockets
  def initialize()
    @dbconnection = DBConnection.new()
    @id_account = Account.new()
  end
  def menu(user_id)
    print "
		Seleccione \n
		1- Ver bolsillo \n
    2- Crear Bolsillo \n
    3- Retirar dinero de un bolsillo \n"

    $selection = gets
    if $selection.to_i == 1
       show_account(user_id)
      menu(user_id)
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
    puts "descripción del bolsillo"
    $description = gets.chomp
    puts "¿cuánto dinero desea ingresar?"
    $money_pokets = gets.chomp
    $money_pokets = $money_pokets.to_i
    account_idS= @id_account.get_account(user_id)
    account_moneyS= @id_account.get_accountmoney(user_id)
    new_account_moneyS = account_moneyS - $money_pokets;
    if new_account_moneyS > 0
      time = Time.new
      results=@dbconnection.query("INSERT INTO `mentoria9`.`pockets` (`account_id`, `name`, `saved_money`, `updated_at`) VALUES ('#{account_idS}', '#{$description}', '#{$money_pokets}', '#{time}')")
      result_money=@dbconnection.query("UPDATE `mentoria9`.`savings_accounts` SET `money`='#{new_account_moneyS}' WHERE  `id`=#{account_idS}")
    else
      puts "No es posible realizar la transacción. Su saldo es insuficiente:"
      print account_moneyS;
    end
    menu(user_id);
  end

  def show_account(user_id)
    account_idS= @id_account.get_account(user_id);
    results=@dbconnection.query("SELECT * FROM pockets where account_id='#{account_idS}' ")
    results.each do |row|
      print row["id"]
      print " "
      print row["name"]
      print " "
      print row["saved_money"]
      puts " "
    end
  end

  def remove_money(user_id)
    show_account(user_id)
    puts "¿id bolsillo?"
    $id_pocket = gets.chomp
    $id_pocket = $id_pocket.to_i
    puts "¿cuánto dinero desea retirar?"
    $saldo = gets.chomp
    $saldo = $saldo.to_i
    $retire_saldo = $saldo.to_i
    $money_start=get_pocket_id($id_pocket)
    $saldo = $money_start.to_i - $saldo.to_i
    $saved_money = get_save_money($id_pocket.to_i)
    account_idS= @id_account.get_account(user_id)
    results=@dbconnection.query("UPDATE `mentoria9`.`pockets` SET `saved_money`=  '#{$saldo}' WHERE id = #{$id_pocket}")
    @id_account.setadd_account(user_id,$retire_saldo)

  end
end

def get_pocket_id(pocket_id)
  results=@dbconnection.query("SELECT * FROM pockets where id='#{pocket_id}' ")
  results.each do |row|
    $money_pocket =row["saved_money"]
  end
  return $money_pocket
end

def get_save_money(id_goal)

  results=@dbconnection.query("SELECT * FROM pockets where id='#{id_goal}' ")
  results.each do |row|
    $saved_money= row["saved_money"]
  end
  return $saved_money
end