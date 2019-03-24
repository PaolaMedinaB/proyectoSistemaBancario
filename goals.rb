require_relative 'DBConnection.rb'
require_relative 'accounts.rb'
class Goals
  def initialize()
    @dbconnection = DBConnection.new()
    @id_account = Account.new()
  end
  def menu(user_id)
    print "
		Seleccione \n
		1- Ver metas \n
    2- Crear meta \n
    3- Agregar dinero \n"
    $selection = gets
    if $selection.to_i == 1
      show_account(user_id)
      menu(user_id)
    elsif $selection.to_i == 2
      add_account(user_id)
    elsif $selection.to_i == 3
      edit_account(user_id)
    else
      puts "¡ERROR!, SELECCIONE UN CAMPO VÁLIDO"
      menu(user_id)
    end
  end

  def add_account(user_id)
    puts "descripcion de la meta"
    $description = gets.chomp
    puts "¿cuánto dinero desea ahorrar para cumplir esta meta?"
    $money_goals = gets.chomp
    $money_goals = $money_goals.to_i
    puts "¿cuál es la fecha límite para cumplir esta meta?"
    $date_goals = gets.chomp
    $date_goals = Date.parse($date_goals)
    account_idS= @id_account.get_account(user_id)
    account_moneyS= @id_account.get_accountmoney(user_id)
    new_account_moneyS = account_moneyS - $money_goals;
    time = Time.new
    results=@dbconnection.query("INSERT INTO `mentoria9`.`goals` (`account_id`, `name`, `deadline` , `target_money`, `saved_money`, `updated_at`) VALUES ('#{account_idS}', '#{$description}', '#{$date_goals}', '#{$money_goals}', '0',  '#{time}')")
    result_money=@dbconnection.query("UPDATE `mentoria9`.`savings_accounts` SET `money`='#{new_account_moneyS}' WHERE  `id`=#{account_idS}")
    puts "No es posible realizar la transacción. Su saldo es insuficiente:"
    print account_moneyS;

    menu(user_id);
  end

  def show_account(user_id)
    account_idS= @id_account.get_account(user_id);
    results=@dbconnection.query("SELECT * FROM goals where account_id='#{account_idS}' ")
    results.each do |row|
      print row["id"]
      print " "
      print row["name"]
      print " "
      print row["saved_money"]
      print " "
      print " Meta:"
      print row["target_money"]
      puts ""
    end
  end

  def edit_account(user_id)
    show_account(user_id)
    puts "¿id meta?"
    $id_goal = gets.chomp
    $id_goal = $id_goal.to_i
    puts "¿cuánto dinero desea añadir para cumplir esta meta?"
    $money_saved = gets.chomp

    $saved_money = get_save_money($id_goal.to_i)
    time = Time.new
    account_idS= @id_account.get_account(user_id)
    account_moneyS= @id_account.get_accountmoney(user_id)
    new_account_moneyS = account_moneyS - $money_saved.to_i
    $money_saved = $money_saved.to_i + $saved_money.to_i
    puts new_account_moneyS
    results=@dbconnection.query("UPDATE `mentoria9`.`goals` SET `saved_money`=  '#{$money_saved}' WHERE id = #{$id_goal}")
    result_money=@dbconnection.query("UPDATE `mentoria9`.`savings_accounts` SET `money`='#{new_account_moneyS}' WHERE  `id`=#{account_idS}")
    menu(user_id)
  end
  def get_save_money(id_goal)

    results=@dbconnection.query("SELECT * FROM goals where id='#{id_goal}' ")
    results.each do |row|
      $saved_money= row["saved_money"]
    end
    return $saved_money
  end
end

