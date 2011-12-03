require 'mongoid'

module Muon
  module API
    module Model
      class TimeEntry
        include Mongoid::Document
        include Mongoid::Timestamps

        field :unit,        type: String
        field :amount,      type: Float
        field :description, type: String
        field :tracked_at,  type: DateTime

        validates_presence_of :tracked_at, :description, :unit, :amount
        before_validation :set_tracked_at

        def set_tracked_at
          self.tracked_at ||= Time.now
        end
      end
    end
  end
end
