require 'rails_helper'

feature 'Register' do
  scenario 'A user can register' do

    visit root_path
    click_on "Sign Up"

    expect(current_path).to eq sign_up_path

    fill_in 'Username', with: "Johnny Dough"
    fill_in 'Email', with: "John@dough.com"
    fill_in 'Password', with: "password"

    click_on "Create Account"
    expect(current_path).to eq root_path
    expect(page).to have_content "Thank you for signing up Johnny Dough"
  end
end
