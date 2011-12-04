require 'muon-api/models'
require 'muon-api/presenters'
require 'grape'

module Muon
  module API
    class Application < Grape::API
      include Muon::API
      version 'v1', using: :header, vendor: 'muon', format: :json

      resource :time_entries do
        get '/' do
          entries = Model::TimeEntry.all.to_a
          present entries, with: Presenter::TimeEntry
        end

        post '/' do
          entry = Model::TimeEntry.create(params)
          present entry, with: Presenter::TimeEntry
          header "Location", "#{File.join(request.url, entry.id.to_s)}"
        end

        get '/:id' do
          entry = Model::TimeEntry.find(params[:id])
          present entry, with: Presenter::TimeEntry
        end

        put '/:id' do
          entry = Model::TimeEntry.find(params[:id])
          entry.update_attributes(params)
          present entry, with: Presenter::TimeEntry
        end

        delete '/:id' do
          entry = Model::TimeEntry.find(params[:id])
          entry.destroy
          status 204
        end
      end
    end
  end
end
