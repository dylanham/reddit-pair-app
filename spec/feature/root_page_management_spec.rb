require 'rails_helper'

feature 'Root path features' do
  scenario 'anyone can visit the root path and see a list of posts' do
    post = create_post
    post2 = create_post
    post3 = create_post
    visit root_path
    expect(page).to have_content "The Black Hole"
    expect(page).to have_content post.title
    expect(page).to have_content post2.title
    expect(page).to have_content post3.title
  end

  scenario 'anyone can click on a post and view its comments' do
    user = create_user
    user2 = create_user
    post = create_post(title: 'Our first post', user_id: user.id)
    comment = create_comment(post_id: post.id, user_id: user.id, content: 'First comment')
    comment2 = create_comment(post_id: post.id, user_id: user2.id, content: 'Second comment')
    comment3 = create_comment
    visit root_path
    click_on post.title
    expect(current_path).to eq post_path(post)
    expect(page).to have_content post.title
    expect(page).to have_content 'Comments'
    expect(page).to have_content 'First comment'
    expect(page).to have_content 'Second comment'
    expect(page).to have_no_content comment3.content
  end
end
