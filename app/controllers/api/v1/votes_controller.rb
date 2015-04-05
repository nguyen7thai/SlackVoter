class Api::V1::VotesController < ApplicationController
  def create
    if survey.votes.exists?(slack_user_name: params[:user_name])
      render json: { status: :ok, text: "Not Accepted. You've already made a choice!!!" }
      return
    end

    vote = survey.votes.build(vote_params)
    if vote.choice == '-1'
      render json: { text: "Invalid choice, please try again, #{vote.slack_user_name}!!" }
      return
    end
    if vote.save
      render json: { text: survey.text_after_vote(vote) }
    else
      render json: { text: 'Something went wrong' }
    end
  end

  private
  def vote_params
    choice = params[:text].gsub(params['trigger_word'], '').strip.downcase
    choice_id = -1

    @survey.options.each_with_index do |option, index|
      tags = option['tag'].downcase.split(',').map(&:strip)
      regex = Regexp.union(tags)
      if choice.match(regex)
        choice_id = index
        break
      end
    end

    {
      slack_user_name: params[:user_name],
      choice: choice_id
    }
  end

  def survey
    @survey ||= Survey.find_by(slack_service_id: params[:service_id])
  end

end
