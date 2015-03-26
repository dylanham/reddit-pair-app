def create_user(options = {})
  User.create!({
    username: "bobross#{rand(1000)+1}",
    email: "example#{rand(1000)+1}@example.com",
    password: 'password'
  }.merge(options))
end

def create_post(options = {})
  Post.create!({
    title: "Cool Post",
    content: "Cool things about stuff!",
    user_id: create_user.id
  }.merge(options))
end

def create_comment(options = {})
  Comment.create!({
    user_id: create_user.id,
    post_id: create_post.id,
    content: "This isn't a cool post...at all"
  }.merge(options))
end
