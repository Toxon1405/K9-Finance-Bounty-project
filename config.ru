# frozen_string_literal: true
# sharable_constant_value: litera

require 'bundler'

Bundler.require

require 'rack/protection'
require 'rack-timeout'
require 'sinatra'
require_relative 'app/quiz'

Rack::Timeout::Logger.disable

use Rack::Timeout, service_timeout: 30
use Rack::Protection, except: :session_hijacking

run Quiz
