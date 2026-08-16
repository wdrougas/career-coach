class HealthController < ApplicationController
  def show
    render json: {
      status: "ok",
      service: "career-coach-api",
      version: "1.0"
    }
  end
end
