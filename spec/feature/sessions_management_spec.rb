require 'rails_helper'

feature 'User can login and logout' do
  scenario 'User can login' do
    user = create_user
    visit root_path
    click_on 'Sign In'
    expect(current_path).to eq sign_in_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    within '.form-group' do
      click_on 'Sign In'
    end
    expect(current_path).to eq root_path
    expect(page).to have_content "Welcome #{user.username}!"
    expect(page).to have_content "Sign Out"
    expect(page).to have_no_content "Sign In"
  end

  scenario 'User can logout' do
    user = create_user
    login(user)
    click_on 'Sign Out'
    expect(current_path).to eq root_path
    expect(page).to have_content 'Sign In'
    expect(page).to have_content 'Sign Up'
    expect(page).to have_no_content 'Sign Out'
  end
end
