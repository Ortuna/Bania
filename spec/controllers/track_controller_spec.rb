require 'rails_helper'

describe TrackController do
  it 'can get a calendar image' do
    get :create
    assert_response :success
  end
end
