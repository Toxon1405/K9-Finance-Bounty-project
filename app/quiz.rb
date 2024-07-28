# frozen_string_literal: true
# sharable_constant_value: literal

require 'sinatra/base'

class Quiz < Sinatra::Base
  require 'zlib'

  require_relative 'quizes'

  enable :sessions

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

  get '/start' do
    quiz_code = params['quiz']
    quiz = Quizes::Quizes[quiz_code]
    raise 'Quiz not found.' unless quiz
    title = "#{quiz[:name]}"
    erb :start, locals: {
      title:,
      quiz_code:,
      quiz:
    }
  end

  get '/question' do
    quiz_code = params['quiz']
    quiz = Quizes::Quizes[quiz_code]
    raise 'Quiz not found.' unless quiz
    qno = params['question'].to_i
    question = quiz[:questions][qno]
    raise 'Question not found.' unless question

    title = "Question ##{qno + 1} / #{quiz[:name]}"
    erb :question, locals: {
      title:,
      quiz_code:,
      qno:,
      question:
    }
  end

  get '/submit' do
    # Somehow save the answer in the session cookie
    # And redirect to the next question if there are any left
    # else redirect to finish overview
  end
end
