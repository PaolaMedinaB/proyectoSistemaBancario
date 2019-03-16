require_relative 'login.rb'
require_relative 'accounts.rb'

class Menu
  def initialize()
    @classUser = Login.new()
    @classAccount = Account.new()
    @user_id = 0
  end
  def menu
    if (@user_id != 0)
      print "
		Seleccione \n
		1- Cuenta  \n
	  2- Bolsillo \n
		3- Metas \n
		4- Colchon \n
		5- Transaccion "
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
    @classAccount.menu()
  end
  def Bolsillo()
    puts "BOLSILLO"
  end
  def Metas()
    puts "METAS"
  end
  def Colchon()
    puts "COLCHON"
  end
  def Transaccion()
    puts "TRANSACCION"
  end
end

#init
object = Menu.new()
object.menu
gets()


