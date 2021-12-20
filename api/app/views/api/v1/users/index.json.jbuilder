json.posts do
  json.array! @posts do |post|
    json.content post
    json.user do
      json.extract! post.user, :id, :name, :nickname, :image
    end
  end
end

json.suggestions do
  json.array! @follower_suggestions, :id, :name, :image, :nickname
end
