class Api::V1::SurveysController < ApplicationController
  def create
    survey = Survey.new(survey_params)
    if survey.save
      SlackApi.new(survey.url).post_message(:new_survey, survey)
      render json: { status: '200' }
    else
      render json: { status: '422' }
    end
  end

  def destroy
  end

  private
  def survey_params
    params.require(:survey).permit(
      :title,
      :description,
      :url,
      options: [[:text, :tag]]
    )
  end
end
