require 'csv'

require 'test_helper'

class UploadsControllerTest < ActionController::TestCase
  setup do
    @csv_basename = 'upload_manuf_sku.csv'

    expected_sku_url_entries = CSV.read(
      Rails.root.join("test/fixtures/#{@csv_basename}")
    )[1..-1]

    @expected_sku_url = Struct.new(
      :entries, :last_entry
    ).new(
      expected_sku_url_entries,
      Struct.new(:manuf, :sku).new(
        *expected_sku_url_entries.last
      )
    )
  end

  def create_upload
    post :create, upload: {
      file: fixture_file_upload(@csv_basename, 'text/csv')
    }
  end

  test 'should create correct sku url entries on upload' do
    assert_difference 'SkuUrl.count', @expected_sku_url.entries.count do
      create_upload
    end
  end

  test 'should create correct last sku url entry' do
    create_upload
    got = SkuUrl.last

    %i[manuf sku].each do |attrib|
      assert(
        got.public_send(attrib) ==
          @expected_sku_url.last_entry.public_send(attrib)
      )
    end
  end
end
