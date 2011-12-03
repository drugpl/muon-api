require 'grape'

module Muon
  module API
    module Presenter
      class TimeEntry < Grape::Entity
        expose :description, :amount, :unit, :created_at, :updated_at, :tracked_at
        expose(:id) { |model, opts| model.id.to_s }
      end
    end
  end
end
