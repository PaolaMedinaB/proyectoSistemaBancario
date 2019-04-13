require_relative 'login.rb'
require_relative 'accounts.rb'
require_relative 'pocket.rb'
require_relative 'mattress.rb'
require_relative 'goals.rb'

class Menu
  def initialize()
    @classUser = Login.new()
    @classAccount = Account.new()
    @classPocket = Pockets.new()
    @classMattress = Mattress.new()
    @classGoals = Goals.new()
    @user_id = 0
  end
  def menu
    case
    when @user_id != 0
      print "
		Seleccione \n
		1- Cuenta  \n
	  2- Transaccion \n
		3- Colchon \n
		4- Bolsillo \n
		5- Metas \n "
      $selection = gets.chomp
    when $selection.to_i == 1
      Cuenta()
    when $selection.to_i == 2
      Transaccion()
    when $selection.to_i == 3
      Colchon()
    when $selection.to_i == 4
      Bolsillo()
    when $selection.to_i == 5
      Metas()
    else
      puts "ERROR SELECCIONE UN CAMPO VALIDO"
      menu()
      end

    else
      @user_id =  @classUser.menu()
    end
    menu()
  end
  def Cuenta()
    @classAccount.menu(@user_id)
  end
  def Bolsillo()
    @classPocket.menu(@user_id)
  end
  def Metas()
   @classGoals.menu(@user_id)
  end
  def Colchon()
    @classMattress.menu(@user_id)
  end
  def Transaccion()
    puts "TRANSACCION"
  end
end

#init
object = Menu.new()
object.menu
gets()
