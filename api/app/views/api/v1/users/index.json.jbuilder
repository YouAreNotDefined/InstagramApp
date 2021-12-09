json.posts do
  json.array! @posts do |post|
    json.content post
    json.user do
      json.extract! post.user, :id, :name, :username, :image
    end
  end
end

json.suggestions do
  json.array! @follower_suggestions, :name, :image, :username
end
