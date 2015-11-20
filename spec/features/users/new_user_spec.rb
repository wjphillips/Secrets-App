require 'rails_helper'
RSpec.describe 'signing up' do
  it 'prompts for valid fields' do
    visit '/users/new'
    expect(page).to have_field('email')
    expect(page).to have_field('name')
    expect(page).to have_field('password')
    expect(page).to have_field('password_confirmation')
  end
end