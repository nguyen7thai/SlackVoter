class SlackApi
  USER_NAME = 'Slack Voter'
  POST_PARAMS = { username: USER_NAME }

  def initialize(url)
    @url = url
  end

  def post_message(action, *args)
    json = send(action, *args)
    RestClient.post @url, json, content_type: :json, accept: :json
  end

  def new_survey(survey)
    POST_PARAMS.merge({
      text: survey.full_description
    }).to_json
  end

end
