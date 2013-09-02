require 'sinatra'
require "sinatra/reloader" if development?
require 'haml'
require 'json'
require 'rack-proxy'

set :public_dir, File.dirname(__FILE__) + '/www'

get '/' do
  send_file 'www/index.html'
end

