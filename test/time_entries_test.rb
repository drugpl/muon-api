require 'test_helper'

class TimeEntriesTest < Muon::API::TestCase
  def valid_params
    {
      description: 'optimizing io-wait',
      amount: 4,
      unit: 'h'
    }
  end

  def test_client_can_submit_entries
    params = valid_params
    @client.post "/time_entries", params do |response|
      assert_equal 201, response.status
      response.body.tap do |entry|
        assert_equal params[:description], entry['description']
        assert_equal params[:amount], entry['amount']
        assert_equal params[:unit], entry['unit']
        refute_nil entry['id']
        refute_nil entry['tracked_at']
        refute_nil entry['created_at']
        refute_nil entry['updated_at']
      end
    end
  end

  def test_client_can_list_time_entries
    params = valid_params
    @client.post "/time_entries", params
    @client.get "/time_entries" do |response|
      assert_equal 200, response.status
      response.body.first.tap do |entry|
        assert_equal params[:description], entry['description']
        assert_equal params[:amount], entry['amount']
        assert_equal params[:unit], entry['unit']
        refute_nil entry['id']
        refute_nil entry['tracked_at']
        refute_nil entry['created_at']
        refute_nil entry['updated_at']
      end
    end
  end

  def test_client_can_show_time_entry_by_id
    params = valid_params
    entry  = @client.post "/time_entries", params
    @client.get "/time_entries/#{entry.body['id']}", params do |response|
      assert_equal 200, response.status
      response.body.tap do |entry|
        assert_equal params[:description], entry['description']
        assert_equal params[:amount], entry['amount']
        assert_equal params[:unit], entry['unit']
        refute_nil entry['id']
        refute_nil entry['tracked_at']
        refute_nil entry['created_at']
        refute_nil entry['updated_at']
      end
    end
  end
end
