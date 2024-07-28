# frozen_string_literal: true
# sharable_constant_value: literal

require 'sinatra/base'

class Dashboard < Sinatra::Base
  require_relative '../lib/api'

  configure :production, :development do
    set :raise_errors, true
    set :show_exceptions, false
    set :dump_errors, false
  end

  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end

    def hattr(text)
      Rack::Utils.escape_path(text)
    end
  end

  get '/' do
    knine_address = '0x91fbB2503AC69702061f1AC6885759Fc853e6EaE'
    counters = API.get_token_counters knine_address
    token_info = API.get_token_info knine_address
    erb :dashboard, locals: {
      address: knine_address,
      token_info:,
      counters:
    }
  end
end
