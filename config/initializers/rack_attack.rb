class Rack::Attack
  ### Configure Cache ###
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  ### Throttle Spammy Clients ###
  throttle('req/ip', limit: 300, period: 5.minutes) do |req|
    req.ip unless req.path.start_with?('/assets', '/packs', '/health')
  end

  # Throttle login attempts by IP address
  throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
    if req.path == '/sessions/new' && req.get?
      req.ip
    end
  end

  # Throttle login attempts by email address
  throttle("logins/email", limit: 5, period: 20.seconds) do |req|
    if req.path == '/sessions' && req.post?
      req.params['email'].presence
    end
  end

  ### Custom Throttle Response ###
  self.throttled_response = lambda do |env|
    [ 429, # status
      {'Content-Type' => 'application/json'}, # headers
      [{ error: "Too many requests. Please try again later." }.to_json] # body
    ]
  end
end 