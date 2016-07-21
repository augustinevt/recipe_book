require('spec_helper')

describe 'List' do
  it {should have_many(:ingredients)}
  it {should have_many(:tags)}
end
