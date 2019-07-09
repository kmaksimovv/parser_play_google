class App < Sequel::Model
  one_to_many :ratings
end
