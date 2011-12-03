ENV['RACK_ENV'] = 'test'

require 'bundler/setup'
require 'muon-api/application'
require 'test/unit'
require 'rack/test'
require 'database_cleaner'
require 'json'
gem 'minitest'

Mongoid.configure do |c|
  c.master = Mongo::Connection.new.db("muon_api_test")
  c.allow_dynamic_fields = false
end

class TestClient
  include MiniTest::Assertions

  attr_accessor :rack_test

  def initialize
    self.rack_test = ::TestClient::RackTest.new
  end

  def get(*args)
    rack_test.get(*args)
    response = JsonResponse.new(rack_test.last_response)
    yield response if block_given?
    response
  end

  def post(*args)
    rack_test.post(*args)
    response = JsonResponse.new(rack_test.last_response)
    yield response if block_given?
    response
  end

  class RackTest
    include Rack::Test::Methods

    def app
      Muon::API::Application
    end
  end

  class JsonResponse
    attr_reader :response
    delegate :status, to: :response

    def initialize(response)
      @response = response
    end

    def body
      @body ||= JSON.parse(@response.body)
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
