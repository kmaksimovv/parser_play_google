class Rating < Sequel::Model
  many_to_one :app
end
