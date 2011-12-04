ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
require 'test/unit'
gem 'minitest'
require 'timecop'

require 'grape'
require 'logger'
Grape::API.logger = Logger.new('/dev/null')

require 'mongoid'
Mongoid.configure do |c|
  c.master = Mongo::Connection.new.db("muon_api_test")
  c.allow_dynamic_fields = false
end

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation

require 'rack/test'
require 'json'
require 'muon-api/application'
class TestClient
  include MiniTest::Assertions

  attr_accessor :rack_test

  def initialize
    self.rack_test = ::TestClient::RackTest.new
  end

  %w(get post put delete).each do |method|
    define_method(method) do |path, params={}, headers={}|
      JsonResponse.new(rack_test.send(method, path, params, headers))
    end
  end

  class RackTest
    include Rack::Test::Methods

    def app
      Muon::API::Application
    end
  end

  class JsonResponse
    attr_reader :response
    delegate :status, :headers, to: :response

    def initialize(response)
      @response = response
    end

    def body
      @body ||= begin
        @response.body.empty?? @response.body : JSON.parse(@response.body)
      end
    end
  end
end

class Muon::API::TestCase < MiniTest::Unit::TestCase
  def setup
    @client = TestClient.new
  end

  def teardown
    DatabaseCleaner.clean
  end
end
