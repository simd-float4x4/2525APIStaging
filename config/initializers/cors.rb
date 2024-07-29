Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
        origins ENV['FRONTEND_ORIGIN_URL'], ENV['FRONTEND_DEVELOPMENT_URL']
        resource '*',
          headers: :any,
          methods: [:get, :post, :patch, :put, :delete, :options, :head],
          credentials: true,
          expose: ['Access-Control-Allow-Origin', 'X-Custom-Header']
    end
end