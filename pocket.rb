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
    2- Crear Bolsillo \n"
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
    puts "descripcion del bolsillo"
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
      puts "pailas prro sul saldp es"
      print account_moneyS;

    end
    menu(user_id);
  end

  def show_account(user_id)
    account_idS= @id_account.get_account(user_id);
    results=@dbconnection.query("SELECT * FROM pockets where account_id='#{account_idS}' ")
    results.each do |row|
      print row["name"]
      print " "
      print row["saved_money"]
      puts " "
    end
    menu(user_id)
  end
end

