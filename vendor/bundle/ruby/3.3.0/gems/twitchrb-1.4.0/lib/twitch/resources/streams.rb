module Twitch
  class StreamsResource < Resource
    def list(**params)
      response = get_request("streams", params: params)

      Collection.from_response(response, type: Stream)
    end

    # Required scope: user:read:follows
    # User ID must match the user in the OAuth token
    def followed(user_id:, **params)
      response = get_request("streams/followed", params: params.merge(user_id: user_id))

      Collection.from_response(response, type: Stream)
    end
  end
end
