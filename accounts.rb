require_relative 'DBConnection.rb'

class Account
  def initialize()
    @dbconnection = DBConnection.new()
  end
  def menu()
    print "
		Seleccione \n
		1- Selecciona"
    $selection = gets
    if $selection.to_i == 1
      return saludo()
    else
      puts "ERROR SELECCIONE UN CAMPO VALIDO"
      menu()
    end
  end
  def saludo()
   puts "PAOLA FEA"
  end
end

#init
object = Account.new()
object.menu
gets()
