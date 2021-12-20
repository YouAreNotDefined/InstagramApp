class Api::V1::GendersController < ApplicationController
  before_action :authenticate_api_v1_user!

  # GET /api/v1/genders
  # GET /api/v1/genders.json
  def index
    @genders = Gender.all
  end
end
