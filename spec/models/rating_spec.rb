require 'spec_helper'
require_relative '../../lib/rating.rb'

RSpec.describe Rating, type: :model do
  describe 'Associations' do
    it{ is_expected.to have_many_to_one(:app) }
  end
end
