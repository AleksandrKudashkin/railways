#modules
require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'validator'

#all the classes
require_relative 'railway_station'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'

trains = []

system 'clear'

def find_train
  puts "Введите регистрационный номер поезда:"
  reg_number = gets.chomp
  found = Train.find(reg_number)
  raise "Поезд не найден!" unless found
  found
end

def find_station
  puts "Введите название станции"
  station_name = gets.chomp
  stations = RailwayStation.all
  this_station = false
  stations.each do |st|
    this_station = st if st.name == station_name
  end
  raise "Станция не найдена!" unless this_station
  this_station
end

def show_station_with_trains(s)
  puts "+++++++++++ Station: #{s.name} ++++++++++++"
  s.each_train do |t|
    puts "Train: #{t.reg_number}, type: #{t.type}, wagons: #{t.wagons.count}"
    t.each_wagon { |w, i| puts "wagon: #{i+1}, type: #{w.type}, taken space: #{w.taken_space}, free space: #{w.free_space}" } if t.type == CargoTrain 
    t.each_wagon { |w, i| puts "wagon: #{i+1}, type: #{w.type}, taken places: #{w.places_taken}, places left: #{w.places_left}" } if t.type == PassangerTrain                
  end
end

loop do
  puts ""
  puts "Меню действий:"
  puts "1. Создать станцию"
  puts "2. Создать поезд"
  puts "3. Добавить вагон к поезду"
  puts "4. Отцепить вагон от поезда"
  puts "5. Занять место/объём в вагоне"
  puts "6. Поместить поезд на станцию"
  puts "7. Вывести список вагонов у поезда"
  puts "8. Просмотреть список станций с поездами"
  puts "9. Посмотреть список поездов на станции"
  puts "10. Выход"
  choice = gets.chomp.to_i

  begin
    case choice
      when 1 #Создать станцию
        puts "Введите название станции:"
        name = gets.chomp
        puts "Станция создана!\n\n" if RailwayStation.new(name)
        
      when 2 #Создать поезд
        puts "Вы хотите создать пассажирский (1) или товарный (2) поезд?"
        type_choice = gets.chomp.to_i
        raise "Необходимо ввести тип поезда 1 (пассажирский) или 2 (товарный)" unless type_choice.between?(1,2)

        puts "Введите регистрационный номер поезда:"
        reg_number = gets.chomp

        if type_choice == 1
          puts "Пасажирский поезд #{reg_number} создан!" if trains << PassangerTrain.new(reg_number) 
        elsif type_choice == 2
          puts "Товарный поезд #{reg_number} создан!" if trains << CargoTrain.new(reg_number) 
        end

      when 3 #Добавить вагон к поезду
        this_train = find_train
          
        if this_train.type == PassangerTrain
          puts "Вы добавляете пассажирский вагон. Укажите количество пассажирских мест:"
          capacity = gets.chomp.to_i
          this_train.attach_wagon(PassangerWagon.new(capacity)) 
          puts "Вагон добавлен к пассажирскому поезду #{this_train.reg_number}"
        elsif this_train.type == CargoTrain
          puts "Вы добавляете грузовой вагон. Укажите общий объём вагона:"
          space = gets.chomp.to_i
          this_train.attach_wagon(CargoWagon.new(space)) 
          puts "Вагон добавлен к товарному поезду #{this_train.reg_number}"
        end

      when 4 #Отцепить вагон от поезда
        this_train = find_train
        puts "Вагон отцеплен от поезда #{this_train.reg_number}" if this_train.detach_wagon

      when 5 #Занять место/объём в вагоне
        this_train = find_train
         
        puts "Введите номер вагона:"
        wagon_number = gets.chomp.to_i
        raise "Sorry, but you should enter a correct digit number" if wagon_number <= 0
        raise "Wagon is not found" if this_train.wagons[wagon_number-1].nil?

        if this_train.type == CargoTrain 
          puts "Какой объём вы хотите занять в вагоне #{wagon_number}?"
          volume = gets.chomp.to_i
          this_train.wagons[wagon_number-1].hold_space(volume)
          puts "Осталось свободного места: #{this_train.wagons[wagon_number-1].free_space}"
        else
          this_train.wagons[wagon_number-1].take_place
          puts "Успешно занято 1 место. Осталось #{this_train.wagons[wagon_number-1].places_left} свободных мест" 
        end

      when 6 #поместить поезд на станцию
        this_train = find_train
        this_station = find_station
        this_station.receive_train(this_train)

      when 7 #вывести список вагонов у поезда
        this_train = find_train
        puts "++++++ #{this_train.type}: #{this_train.reg_number} +++++++"
        this_train.each_wagon { |w, i| puts "wagon: #{i+1}, type: #{w.type}, taken space: #{w.taken_space}, free space: #{w.free_space}" } if this_train.type == CargoTrain
        this_train.each_wagon { |w, i| puts "wagon: #{i+1}, type: #{w.type}, taken places: #{w.places_taken}, places left: #{w.places_left}" } if this_train.type == PassangerTrain

      when 8 #показать список станций с поездами
        stations = RailwayStation.all
        stations.each { |s| show_station_with_trains(s) }

      when 9 #показать список поездов на станции
        this_station = find_station
        show_station_with_trains(this_station)
        
      when 10 #Выход
        break
    end
  rescue RuntimeError => e
    puts "******************************"
    puts "К сожалению, произошла ошибка:"
    puts e.message
    puts "******************************"
    next
  end
end