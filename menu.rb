require_relative 'login.rb'
require_relative 'accounts.rb'
require_relative 'pocket.rb'
require_relative 'mattress.rb'

class Menu
  def initialize()
    @classUser = Login.new()
    @classAccount = Account.new()
    @classPocket = Pockets.new()
    @classMattress = Mattress.new()
    @user_id = 0
  end
  def menu
    if (@user_id != 0)
      print "
		Seleccione \n
		1- Cuenta  \n
	  2- Transaccion \n
		3- Colchon \n
		4- Bolsillo \n
		5- Metas \n "
      $selection = gets
      if $selection.to_i == 1
        Cuenta()
      elsif $selection.to_i == 2
        Transaccion()
      elsif $selection.to_i == 3
        Colchon()
      elsif $selection.to_i == 4
        Bolsillo()
      elsif $selection.to_i == 5
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
    puts "METAS"
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


