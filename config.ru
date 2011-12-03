require 'muon-api'

Mongoid.configure do |c|
  c.master = Mongo::Connection.new.db("muon-api")
end

run Muon::API::Application
