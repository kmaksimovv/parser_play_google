require 'spec_helper'
require_relative '../../lib/app.rb'

RSpec.describe App, type: :model do
  describe 'Associations' do
    it{ is_expected.to have_one_to_many(:ratings) }
  end
end
