require 'test_helper'

class TimeEntriesTest < Muon::API::TestCase
  def test_client_can_list_time_entries
    @client.get '/time_entries' do |r|
      assert_equal 200, r.status
      assert_equal [], r.body
    end
  end
end
