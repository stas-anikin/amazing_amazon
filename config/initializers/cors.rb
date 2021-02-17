Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # orgin acccepts an array of domain names. These are all the whitelisted DOMAINS that are allowed to 			make CORS request
    origins "localhost:5500", "127.0.0.1:5500" # You can add any domain name of your choice
    resource(
      "/api/*", # only allows CORS requeswts to a path that looks like /api
      headers: :any, # allow requests to contain any headers
      credentials: true, # allows us to send cookies through CORS requests
      methods: [:get, :post, :delete, :patch, :put, :options],
    )
  end
end
