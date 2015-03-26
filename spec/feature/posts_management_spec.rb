require 'rails_helper'

feature 'User can do lots of stuff with posts' do

  scenario 'Only a logged in user can make a new post' do
    user = create_user
    login(user)
    expect(current_path).to eq root_path
    click_on "New Post"
    fill_in "Title", with: "My Favorite Post Ever"
    fill_in "Content", with: "I love this post alot"
    click_on "Create Post"
    expect(page).to have_content "My Favorite Post Ever"
    expect(page).to have_content "The Black Hole has recieved your post"
  end

  scenario 'A visitor should be redirected to sign in if trying to make a new post' do
    visit root_path
    click_on "New Post"
    expect(current_path).to eq sign_in_path
    expect(page).to have_content 'Please sign in first'
  end

  scenario 'Only a logged in user can comment on a post' do
    user = create_user
    login(user)
    post = create_post
    visit post_path(post)
    expect(page).to have_content post.title
    fill_in 'Content', with: 'This post was pretty cool'
    click_on 'Create Comment'
    expect(page).to have_content 'Comment added'
    expect(page).to have_content 'This post was pretty cool'
  end

  scenario 'A visitor is redirected to sign in if trying to comment on a post' do
    post = create_post
    visit post_path(post)
    fill_in "Content", with: "Can I save this comment?!"
    click_on "Create Comment"
    expect(current_path).to eq sign_in_path
    expect(page).to have_content "Please sign in first"
  end

  scenario 'An owner of a post can edit their post' do
    user = create_user
    post = create_post(user_id: user.id)
    login(user)
    visit post_path(post)
    expect(page).to have_content 'Edit'
    click_on 'Edit'
    expect(current_path).to eq edit_post_path(post)
    fill_in 'Title', with: 'HAHA I changed this Title'
    fill_in 'Content', with: 'Your comments make no sense now'
    click_on 'Update Post'
    expect(current_path).to eq post_path(post)
    expect(page).to have_content 'The Black Hole has accepted your changes'
    expect(page).to have_content 'HAHA I changed this Title'
    expect(page).to have_no_content 'Cool Post'
  end

  scenario 'A current user who is not the owner of a post is redirected to root' do
    user = create_user
    post = create_post
    login(user)
    visit post_path(post)
    click_on "Edit"
    expect(page).to have_content "Hey! You can't do that. Silly"
    expect(current_path).to eq root_path
  end

  scenario 'A visitor cannot edit a post and is redirected to root' do
    post = create_post
    visit post_path(post)
    click_on "Edit"
    expect(page).to have_content "Please sign in first"
    expect(current_path).to eq sign_in_path
  end
  scenario 'Only the owner of a post can delete that post' do
    user = create_user
    post = create_post(user_id: user.id)
    login(user)
    visit post_path(post)
    click_on "Delete Post"
    expect(current_path).to eq root_path
    expect(page).to have_content 'The Blackhole has swallowed your post!'
    expect(page).to have_no_content 'Cool Post'
  end

  scenario 'A current user who is not the owner of a post is redirected to root' do
    user = create_user
    post = create_post
    login(user)
    visit post_path(post)
    click_on "Delete Post"
    expect(page).to have_content "Hey! You can't do that. Silly"
    expect(current_path).to eq root_path
  end

  scenario 'A visitor cannot edit a post and is redirected to root' do
    post = create_post
    visit post_path(post)
    click_on "Delete"
    expect(page).to have_content "Please sign in first"
    expect(current_path).to eq sign_in_path
  end
end
