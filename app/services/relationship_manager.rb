class RelationshipManager
  attr_reader :errors

  def initialize(current_user:, target_user:)
    @current_user = current_user
    @target_user = target_user
    @errors = []
  end

  def process
    action = define_action(current_user: @current_user, target_user: @target_user)
    send(action)
    @errors.blank?
  end

  private

  def define_action(current_user:, target_user:)
    if @current_user.followees&.include?(@target_user)
      :unfollow_target_user
    else
      :follow_target_user
    end
  end

  def follow_target_user
    relationship = Relationship.new(follower: @current_user, followee: @target_user)
    result = relationship.save!
    @errors << relationship.errors.messages unless result
  end

  def unfollow_target_user
    relationship = Relationship.find_by(follower: @current_user, followee: @target_user)
    result = relationship.destroy!

    @errors << relationship.errors.messages unless result
  end

  def has_errors?
    @errors.any?
  end
end
