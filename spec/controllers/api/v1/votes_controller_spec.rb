require 'rails_helper'

describe Api::V1::VotesController do
  it 'should pass' do
    post :create, api_v1_votings_url
    expect(response).to be_success
  end
end
