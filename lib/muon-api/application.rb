require 'muon-api/models'
require 'grape'

module Muon
  module API
    class Application < Grape::API
      # version 'v1', using: :header, vendor: 'muon', format: :json

      resource :time_entries do
        get '/' do
          Muon::API::TimeEntry.all
        end

        post '/' do
          Muon::API::TimeEntry.create(params)
        end

        get '/:id' do
          Muon::API::TimeEntry.find(params[:id])
        end
      end
    end
  end
end
