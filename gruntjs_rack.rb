require 'rerun'

module Rack
  class Gruntjs
    def initialize(app)
      @app = app
      @last_grunt = nil
    end

    def call(env)
      if @last_grunt == nil || (Time.now - @last_grunt) > 5
        system('./gruntjs.sh')
        sleep(1)
        @last_grunt = Time.now
      end
      @app.call(env)
    end
  end
end