class HealthController < ApplicationController
  # Skip any authentication or CSRF checks for health checks
  skip_before_action :verify_authenticity_token
  
  def show
    head :ok
  end
end 