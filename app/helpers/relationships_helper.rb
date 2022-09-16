module RelationshipsHelper
  def user_relationships id
    current_user.active_relationships.find_by(followed_id: id)
  end
end
