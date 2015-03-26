def login(user)
  visit root_path
  click_on 'Sign In'
  expect(current_path).to eq sign_in_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  within '.form-group' do
    click_on 'Sign In'
  end
end
