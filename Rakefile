require 'rake/testtask'

Rake::TestTask.new do |t|
  t.pattern = "test/*/*_test.rb"
end

task default: :test

# seed data
require_relative './lib/services.rb'
require_relative './lib/service_types.rb'

namespace :seeds do

  task :service_types do
    service_type_params = [
      {:name => "Tune Ups"},
      {:name => "Wheels"},
      {:name => "Tubes and Tires"},
      {:name => "Brakes"},
      {:name => "Drivetrain"},
      {:name => "Bearings"},
      {:name => "ETC"},
      {:name => "Thread Frame Treatments"}
    ]

    service_type_params.each do |obj_params|
      ServiceTypes.save(ServiceType.new(obj_params))
    end
    puts "Services types count: #{ServiceTypes.all.count}"

    service_type_params.each do |_k,v| # makes instance vars like @wheels
      val = _k[:name]
      instance_val = val.downcase.gsub(/\s+/,"")
      instance_variable_set("@#{instance_val}", ServiceTypes.find_all_by_name(val).first.id.to_i)
    end
  end

  task :services do
    service_params = [
      {:name => 'Basic', :service_type_id => @tuneups, :price_details => '25'},
      {:name => 'Standard', :service_type_id => @tuneups, :price_details => '65'},
      {:name => 'Premium', :service_type_id => @tuneups, :price_details => '100'},
      {:name => 'Trued', :service_type_id => @wheels, :price_details=> '15 base price'},
      {:name => 'Broken Spokes', :service_type_id => @wheels, :price_details=> '15'},
      {:name => 'Re-Tensioned', :service_type_id => @wheels, :price_details=> '30'},
      {:name => 'Wheel Build', :service_type_id => @wheels, :price_details=> '50 each wheel + cost of parts'},
      {:name => 'Install New Wheel', :service_type_id => @wheels, :price_details=> '15 Rear'},
      {:name => 'Tube installation', :service_type_id => @tubesandtires, :price_details=> '5 per wheel'},
      {:name => 'Tire installation', :service_type_id => @tubesandtires, :price_details=> '5 per wheel'},
      {:name => 'Slime injection', :service_type_id => @tubesandtires, :price_details=> '5 per wheel'},
      {:name => 'Internal Hub', :service_type_id => @tubesandtires, :price_details=> '10'},
      {:name => 'Coster Brake', :service_type_id => @tubesandtires, :price_details=> '10'},
      {:name => 'Adjustment & Alignment', :service_type_id => @brakes, :price_details=> '10 per brake'},
      {:name => 'Pad Replacement', :service_type_id => @brakes, :price_details=> '5'},
      {:name => 'Cable Replacement', :service_type_id => @brakes, :price_details=> '10 per brake'},
      {:name => 'Caliper Installation', :service_type_id => @brakes, :price_details=> '15 per brake'},
      {:name => 'Brake Lever Installation', :service_type_id => @brakes, :price_details=> '15'},
      {:name => 'Disc Brake Bleed', :service_type_id => @brakes, :price_details=> '30'},
      {:name => 'Rotor Replacement', :service_type_id => @brakes, :price_details=> '5'},
      {:name => 'Rotor Truing', :service_type_id => @brakes, :price_details=> '10'},
      {:name => 'Derailleur Adjustment', :service_type_id => @drivetrain, :price_details=> '10 per derailleur'},
      {:name => 'Cable Replacement', :service_type_id => @drivetrain, :price_details=> '10 per derailleur'},
      {:name => 'Derailleur Installation', :service_type_id => @drivetrain, :price_details=> '15 per derailleur'},
      {:name => 'Derailleur Hanger Straightening', :service_type_id => @drivetrain, :price_details=> '15'},
      {:name => 'Shifter Installation', :service_type_id => @drivetrain, :price_details=> '15'},
      {:name => 'Chain Installation', :service_type_id => @drivetrain, :price_details=> '5'},
      {:name => 'Freewheel or Cassette Installation', :service_type_id => @drivetrain, :price_details=> '5'},
      {:name => 'Crank Installation', :service_type_id => @drivetrain, :price_details=> '15'},
      {:name => 'Chainring Installation', :service_type_id => @drivetrain, :price_details=> '15'},
      {:name => 'Headset Adjustment', :service_type_id => @bearings, :price_details=> '5'},
      {:name => 'Headset Overhaul', :service_type_id => @bearings, :price_details=> '15'},
      {:name => 'Headset Installation', :service_type_id => @bearings, :price_details=> '25'},
      {:name => 'Fork Installation', :service_type_id => @bearings, :price_details=> '20'},
      {:name => 'Hub Adjustment', :service_type_id => @bearings, :price_details=> '5'},
      {:name => 'Hub Overhaul', :service_type_id => @bearings, :price_details=> '20'},
      {:name => 'Bottom Bracket Adjustment', :service_type_id => @bearings, :price_details=> '10'},
      {:name => 'Bottom Bracket Overhaul', :service_type_id => @bearings, :price_details=> '20'},
      {:name => 'Bottom Bracket Installation', :service_type_id => @bearings, :price_details=> '20 for cartridge'},
      {:name => 'Handlebar Installation', :service_type_id => @etc, :price_details=> '15 for flat'},
      {:name => 'Stem Installation', :service_type_id => @etc, :price_details=> '15-25'},
      {:name => 'Wrap Bars', :service_type_id => @etc, :price_details=> '10'},
      {:name => 'Grip Installation', :service_type_id => @etc, :price_details=> '5'},
      {:name => 'Saddle Installation', :service_type_id => @etc, :price_details=> '5'},
      {:name => 'Pedal Installation', :service_type_id => @etc, :price_details=> '5'},
      {:name => 'Rack Installation', :service_type_id => @etc, :price_details=> '15'},
      {:name => 'Computer Installation', :service_type_id => @etc, :price_details=> '20'},
      {:name => 'Training Wheel Installation', :service_type_id => @etc, :price_details=> '15'},
      {:name => 'Tap Crank Arm', :service_type_id => @threadframetreatments, :price_details=> '5 per arm'},
      {:name => 'Helicoil Installation (crank saver)', :service_type_id => @threadframetreatments, :price_details=> '15'},
      {:name => 'Face Bottom Bracket Shell', :service_type_id => @threadframetreatments, :price_details=> '15-25'},
      {:name => 'Face Head Tube', :service_type_id => @threadframetreatments, :price_details=> '15-25'},
      {:name => 'Chase Bottom Bracket', :service_type_id => @threadframetreatments, :price_details=> '15-25'}
    ]

    service_params.each do |obj_params|
      Services.save(Service.new(obj_params))
    end

    puts "Services count: #{Services.all.count}"
  end

  task :all => [:service_types, :services]

end


namespace :clean_database do

  task :reset_tables do
    Services.dataset.delete
    ServiceTypes.dataset.delete
    puts "!! - Reset tables"
    puts "Services types count: #{ServiceTypes.all.count}"
    puts "Services count: #{Services.all.count}"
  end

end
