# encoding: utf-8
# frozen_string_literal: true
# modules
require_relative 'instance_counter'
require_relative 'manufacturer'
require_relative 'validator'

# all the classes
require_relative 'railway_station'
require_relative 'route'
require_relative 'train'
require_relative 'wagon'

trains = []

system 'clear'

def find_train
  puts "Please, enter an identification number of the train:"
  reg_number = gets.chomp
  found = Train.find(reg_number)
  raise "The train was not found!" unless found
  found
end

def find_station
  puts "Please, enter a railway station's name:"
  station_name = gets.chomp
  stations = RailwayStation.all
  this_station = false
  stations.each do |st|
    this_station = st if st.name == station_name
  end
  raise "The railway station was not found!" unless this_station
  this_station
end

def show_wagon(train_type, w, i)
  message = "wagon: #{i + 1}, "
  message << "type: #{w.type}, "
  if train_type == 'cargo'
    message << "taken space: #{w.taken_space}, "
    message << "free space: #{w.free_space}"
  elsif train_type == 'passanger'
    message << "taken places: #{w.places_taken}, "
    message << "places left: #{w.places_left}"
  end
  message
end

def show_wagons(train)
  if train.type == CargoTrain
    train.each_wagon { |w, i| puts show_wagon('cargo', w, i) }
  elsif train.type == PassangerTrain
    train.each_wagon { |w, i| puts show_wagon('passanger', w, i) }
  end
end

def trains_of_station(s)
  puts "+++++++++++ Station: #{s.name} ++++++++++++"
  s.each_train do |t|
    puts "Train: #{t.reg_number}, type: #{t.type}, wagons: #{t.wagons.count}"
    show_wagons(t)
  end
end

def get_capacity(train_type)
  message = "You are attaching a #{train_type} wagon to the #{train_type} train. "
  message << "How many seats it will have?" if train_type == 'passanger'
  message << "What volume it will have?" if train_type == 'cargo'
  puts message
  gets.chomp.to_i
end

loop do
  puts ""
  puts "What you can do:"
  puts "1. Create a railway station"
  puts "2. Create a train"
  puts "3. Attach a wagon to a train"
  puts "4. Detach a wagon from a train"
  puts "5. Take place/volume in a train"
  puts "6. Move a train to a railway station"
  puts "7. Print a list of wagons of a train"
  puts "8. Print a list of railway stations and trains on them"
  puts "9. Print a list of trains on a particular railway station"
  puts "10. Exit"
  choice = gets.chomp.to_i

  begin
    case choice
    when 1 # Create a railway station
      puts "Enter a railway station's name:"
      name = gets.chomp
      puts "The station has been created!\n\n" if RailwayStation.new(name)

    when 2 # Create a train
      puts "Do you want to create a passanger train (1) or a cargo train (2)?"
      type_choice = gets.chomp.to_i
      err_msg = "You need to enter a type of a train: "
      err_msg << "1 (for passanger) or 2 (for cargo)"
      raise err_msg unless type_choice.between?(1, 2)

      puts "Please, enter an identification number of the train:"
      reg_number = gets.chomp

      if type_choice == 1
        if trains << PassangerTrain.new(reg_number)
          puts "Passanger train #{reg_number} has been created!"
        end
      elsif type_choice == 2
        if trains << CargoTrain.new(reg_number)
          puts "Cargo train #{reg_number} has been created!"
        end
      end

    when 3 # Attach a wagon
      this_train = find_train

      if this_train.type == PassangerTrain
        capacity = get_capacity('passanger')

        this_train.attach_wagon(PassangerWagon.new(capacity))

        message = "The passanger wagon has been attached to a passanger train "
        message << this_train.reg_number.to_s
        puts message

      elsif this_train.type == CargoTrain
        space = get_capacity('cargo')
        this_train.attach_wagon(CargoWagon.new(space))

        message = "The cargo train has been attached to a cargo train "
        message << this_train.reg_number.to_s
        puts message
      end

    when 4 # Detach a wagon
      this_train = find_train
      puts "The wagon has been detached from the train
            #{this_train.reg_number}" if this_train.detach_wagon

    when 5 # Take place/volume
      this_train = find_train

      puts "Please, enter a wagon's number:"
      wagon_number = gets.chomp.to_i
      raise "Sorry, but you should enter a correct digit number" if wagon_number <= 0
      raise "Wagon is not found" if this_train.wagons[wagon_number - 1].nil?

      if this_train.type == CargoTrain
        puts "How much volume you will take in wagon #{wagon_number}?"
        volume = gets.chomp.to_i
        this_train.wagons[wagon_number - 1].hold_space(volume)
        message = "There is #{this_train.wagons[wagon_number - 1].free_space} "
        message << "of free space remains"
      else
        this_train.wagons[wagon_number - 1].take_place
        message = "You have succesfully take one seat. "
        message << "#{this_train.wagons[wagon_number - 1].places_left} seats remains"
      end
      puts message

    when 6 # Move a train to a station
      this_train = find_train
      this_station = find_station
      this_station.receive_train(this_train)

    when 7 # Print a list of wagons of a pacticular train
      this_train = find_train
      puts "++++++ #{this_train.type}: #{this_train.reg_number} +++++++"
      show_wagons(this_train)

    when 8 # Print a list of stations with trains on them
      stations = RailwayStation.all
      stations.each { |s| trains_of_station(s) }

    when 9 # Show list of a trains on a particular station
      this_station = find_station
      trains_of_station(this_station)

    when 10 # Exit
      break
    end
  rescue RuntimeError => e
    puts "******************************"
    puts "Sorry, but there is an error:"
    puts e.message
    puts "******************************"
    next
  end
end
