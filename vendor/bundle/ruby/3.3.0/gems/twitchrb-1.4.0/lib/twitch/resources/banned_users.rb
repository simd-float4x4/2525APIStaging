module Twitch
  class BannedUsersResource < Resource
    # Broadcaster ID must match the user in the OAuth token
    def list(broadcaster_id:, **params)
      response = get_request("moderation/banned", params: params.merge(broadcaster_id: broadcaster_id))
      Collection.from_response(response, type: BannedUser)
    end

    # Required scope: moderator:manage:banned_users
    # moderator_id must match the currently authenticated user. Can be either the broadcaster ID or moderator ID
    def create(broadcaster_id:, moderator_id:, user_id:, reason:, duration: nil)
      attrs = { broadcaster_id: broadcaster_id, moderator_id: moderator_id, data: { user_id: user_id, reason: reason, duration: duration } }
      response = post_request("moderation/bans", body: attrs)
      BannedUser.new response.body.dig("data")[0]
    end

    # Required scope: moderator:manage:banned_users
    # moderator_id must match the currently authenticated user. Can be either the broadcaster ID or moderator ID
    def delete(broadcaster_id:, moderator_id:, user_id:)
      delete_request("moderation/bans?broadcaster_id=#{broadcaster_id}&moderator_id=#{moderator_id}&user_id=#{user_id}")
    end
  end
end
