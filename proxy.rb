class Proxy < Rack::Proxy
  def initialize(app)
    @app = app
  end

  def call(env)
    original_host = env["HTTP_HOST"]
    rewrite_env(env)

    if env["HTTP_HOST"] != original_host
      perform_request(env)
    else
      @app.call(env)
    end
  end

  def rewrite_env(env)
    request = Rack::Request.new(env)
    #http://stackoverflow.com/questions/9731649/match-a-string-against-multiple-paterns
    dont_redirect = [
      /\/css\/.*/,
      /\/js\/.*/,
      /\/img\/.*/,
      /\/assets\/.*/,
      /\/config.xml/,
      /\/cordova.js/,
      /\/phonegap.js/,
      /\/cordova_plugins.json/,
      /\/templogo.png/,
      /\/favicon.ico/
    ]

    regex_dont_redirect = Regexp.union(dont_redirect)

    unless  request.path.match(regex_dont_redirect) || request.path == '/'
      env["HTTP_HOST"] = "http://localhost:4568"
      print 'redirecting: ' + request.path
    end
    env
  end
end