require 'test_helper'

class TimeEntriesTest < Muon::API::TestCase
  def valid_params
    {
      description: 'optimizing io-wait',
      amount: 4.0,
      unit: 'h'
    }
  end

  def test_client_can_submit_entries
    params = valid_params
    @client.post("/time_entries", params).tap do |response|
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
    @client.post("/time_entries", params)
    @client.get("/time_entries").tap do |response|
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

  def test_client_can_show_time_entry
    params = valid_params
    entry  = @client.post("/time_entries", params).body
    @client.get("/time_entries/#{entry['id']}", params).tap do |response|
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

  def test_client_can_update_time_entry
    params    = valid_params
    amount    = params[:amount] + 2
    original  = @client.post("/time_entries", params).body
    Timecop.travel(1.minute.from_now)
    @client.put("/time_entries/#{original['id']}", {amount: amount}).tap do |response|
      assert_equal 200, response.status
      response.body.tap do |entry|
        assert_equal params[:description], entry['description']
        assert_equal amount, entry['amount']
        assert_equal params[:unit], entry['unit']
        assert_equal original['id'], entry['id']
        assert_equal original['tracked_at'], entry['tracked_at']
        assert_equal original['created_at'], entry['created_at']
        refute_equal original['updated_at'], entry['updated_at']
      end
    end
  end

  def test_client_can_delete_time_entry
    params = valid_params
    entry  = @client.post "/time_entries", params
    @client.delete("/time_entries/#{entry.body['id']}", params).tap do |response|
      assert_equal 204, response.status
      assert response.body.empty?
    end
  end
end
