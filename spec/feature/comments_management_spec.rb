require 'rails_helper'

feature "Comments" do

  scenario 'only the owner of a comment can edit their comment' do
    user = create_user
    post = create_post
    comment = create_comment(post_id: post.id, user_id: user.id)
    login(user)
    visit post_path(post)
    click_on "Edit Comment"
    expect(current_path).to eq edit_post_comment_path(post, comment)
    fill_in "Content", with: "Trident"
    click_on "Update Comment"
    expect(current_path).to eq post_path(post)
    expect(page).to have_content "Mountains are Merely Mountains. Way to update that comment!"
    expect(page).to have_content "Trident"
    expect(page).to have_no_content "This isn't a cool post...at all"
  end

  scenario 'A current user who is not the owner of a comment cannot see edit and is redirected to root if trying to hack params' do
    user = create_user
    post = create_post
    comment = create_comment(post_id: post.id)
    login(user)
    visit post_path(post)
    expect(page).to have_no_content 'Edit Comment'
  end

  scenario 'A visitor cannot edit a comment and is redirected to root' do
    post = create_post
    comment = create_comment(post_id: post.id)
    visit edit_post_comment_path(post, comment)
    expect(page).to have_content "Please sign in first"
    expect(current_path).to eq sign_in_path
  end

  scenario 'only the owner of a comment can edit their comment' do
    user = create_user
    post = create_post
    comment = create_comment(post_id: post.id, user_id: user.id)
    login(user)
    visit post_path(post)
    click_on "Delete Comment"
    expect(current_path).to eq post_path(post)
    expect(page).to have_content "GOODBYE COMMENT!"
    expect(page).to have_no_content "This isn't a cool post...at all"
  end
  scenario 'A non logged in user is cannot delete a comment' do
    post = create_post
    comment = create_comment(post_id: post.id)
    visit post_path(post)
    expect(page).to have_no_content "Delete Comment"
  end
  scenario "a logged in user, that is not the owner of a comment cannot delete another users comment" do
    user = create_user
    login(user)
    post = create_post
    comment = create_comment(post_id: post.id)
    visit post_path(post)
    expect(page).to have_no_content "Delete Comment"
  end
end
