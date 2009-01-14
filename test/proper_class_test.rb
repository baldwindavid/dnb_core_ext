require 'rubygems'
require 'test/unit'
require 'shoulda'

require File.dirname(__FILE__) + '/../init'

class ProperClassTest < Test::Unit::TestCase
  
  context "A String representing" do

    context "an Integer" do
      should "respond to integer? as true" do
        assert_equal "47".integer?, true
      end
    end
    
    context "a Float" do
      should "respond to float? as true" do
        assert_equal "73.2789".float?, true
      end
    end
    
    context "a Boolean" do
      should "respond to boolean? as true" do
        assert_equal "false".boolean?, true
      end
    end
    
  end
  
  context "A Hash of improperly classed values" do
    setup do
      
      improper_values = { 
        :pet => 'dog', 
        :name => 'Fido', 
        :state => 'Indiana', 
        'is_trained?' => 'false', 
        'is_old?' => 'true', 
        'how_old?' => '7',
        'some_num' => '4.355',
        'extras' => {
        :usage => 'document',
        'town' => 'Indianapolis',
        'pi' => '3.14',
        :new_record => 'true',
        'other_stuff' => {
           'color' => 'brown',
           :vehicle => 'truck',
           'year' => '1942',
           'another_decimal' => '9.81',
           :good => 'true',
           :some_array => [
             'thing', 
             '3.78',
             {
               :teams => [ "Colts", "Bears", "Chargers"],
               :city => "Indianapolis"
              }
            ]
          }
        }
      }
      
      @converted_values_with_string_keys = improper_values.values_to_proper_class(false)
      @converted_values_with_symbol_keys = improper_values.values_to_proper_class
    
      @proper_values_with_string_keys = { "name"=>"Fido",
       "is_old?"=>true,
       "is_trained?"=>false,
       "how_old?"=>7,
       "extras"=>
        { "usage"=>"document",
         "pi"=>3.14,
         "other_stuff"=>
          { "good"=>true,
           "another_decimal"=>9.81,
           "vehicle"=>"truck",
           "some_array"=>
            [ "thing",
             3.78,
             { "city"=>"Indianapolis", "teams"=>["Colts", "Bears", "Chargers"] }
            ],
           "color"=>"brown",
           "year"=>1942
          },
         "new_record"=>true,
         "town"=>"Indianapolis"
         },
         "some_num"=>4.355,
         "pet"=>"dog",
         "state"=>"Indiana"
        }
      
      @proper_values_with_symbol_keys = { 
        :pet => 'dog', 
        :name => 'Fido', 
        :state => 'Indiana', 
        :is_trained? => false, 
        :is_old? => true, 
        :how_old? => 7,
        :some_num => 4.355,
        :extras => {
        :usage => 'document',
        :town => 'Indianapolis',
        :pi => 3.14,
        :new_record => true,
        :other_stuff => {
           :color => 'brown',
           :vehicle => 'truck',
           :year => 1942,
           :another_decimal => 9.81,
           :good => true,
           :some_array => [
             'thing', 
             3.78,
             {
               :teams => [ "Colts", "Bears", "Chargers"],
               :city => "Indianapolis"
              }
            ]
          }
        }
      }
    end

    should "be converted to properly classed values with strings as keys" do
      assert_equal @converted_values_with_string_keys, @proper_values_with_string_keys
    end

    should "be converted to properly classed values with symbols as keys" do
      assert_equal @converted_values_with_symbol_keys, @proper_values_with_symbol_keys
    end
  end
    
    
end
