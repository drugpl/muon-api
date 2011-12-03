require 'mongoid'

module Muon
  module API
    class TimeEntry
      include Mongoid::Document
      include Mongoid::Timestamps

      field :minutes, type: Integer
    end
  end
end
