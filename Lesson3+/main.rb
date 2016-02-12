require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'railway_station'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'

stations = []
trains = []

loop do
  puts "Меню действий:"
  puts "1. Создать станцию"
  puts "2. Создать поезд"
  puts "3. Добавить вагон к поезду"
  puts "4. Отцепить вагон от поезда"
  puts "5. Поместить поезд на станцию"
  puts "6. Просмотреть список станций с поездами"
  puts "7. Выход"
  choice = gets.chomp.to_i

  case choice
    when 1 #Создать станцию
      puts "Введите название станции:"
      name = gets.chomp
      puts "Станция создана!\n\n" if stations << RailwayStation.new(name)
    when 2 #Создать поезд
      puts "Вы хотите создать пассажирский (1) или товарный (2) поезд?"
      type_choice = gets.chomp.to_i

      puts "Введите регистрационный номер поезда:"
      reg_number = gets.chomp
      if type_choice == 1
        puts "Пасажирский поезд #{reg_number} создан!" if trains << PassangerTrain.new(reg_number) 
      elsif type_choice == 2
        puts "Товарный поезд #{reg_number} создан!" if trains << CargoTrain.new(reg_number) 
      end
    when 3 #Добавить вагон к поезду
      puts "Введите регистрационный номер поезда:"
      reg_number = gets.chomp
      this_train = false
      trains.each do |t|
        this_train = t if t.reg_number == reg_number
      end
      
      if not this_train
        puts "Поезд не найден!"
        next
      end

      if this_train.type == 1
        this_train.attach_wagon(PassangerWagon.new) 
        puts "Вагон добавлен к пассажирскому поезду #{this_train.reg_number}"
      elsif this_train.type == 2
        this_train.attach_wagon(CargoWagon.new) 
        puts "Вагон добавлен к товарному поезду #{this_train.reg_number}"
      end
    when 4 #Отцепить вагон от поезда
      puts "Введите регистрационный номер поезда:"
      reg_number = gets.chomp
      this_train = false
      trains.each do |t|
        this_train = t if t.reg_number == reg_number
      end
      
      if not this_train
        puts "Поезд не найден!"
        next
      end

      puts "Вагон отцеплен от поезда #{this_train.reg_number}" if this_train.detach_wagon
    when 5 #поместить поезд на станцию
      puts "Введите регистрационный номер поезда:"
      reg_number = gets.chomp
      this_train = false
      trains.each do |t|
        this_train = t if t.reg_number == reg_number
      end
      
      if not this_train
        puts "Поезд не найден!"
        next
      end

      puts "Введите название станции"
      station_name = gets.chomp
      this_station = false
      stations.each do |st|
        this_station = st if st.name == station_name
      end
      
      if not this_station
        puts "Станция не найдена!"
        next
      end

      this_station.receive_train(this_train)
    when 6 #показать список станций с поездами
      stations.each do |st|
        puts "Станция: #{st.name}"
        puts "Поезда: "
        st.show_all_trains
      end
    when 7 #Выход
      break
  end
end