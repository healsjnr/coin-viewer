require 'spec_helper'

describe 'main site tests' do
  it 'should load the home page' do
    visit '/'
    page.should have_content('Title of Page')
  end
end
