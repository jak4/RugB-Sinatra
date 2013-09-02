$LOAD_PATH << File.expand_path(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'
require 'sinatra'
require 'app'
require 'gruntjs_rack'
require 'rack-proxy'
require 'proxy'

use Rack::Gruntjs
use Proxy

run Sinatra::Application
