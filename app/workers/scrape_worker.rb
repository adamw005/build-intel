class ScrapeWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(urls)
    proxy = "proxy.crawlera.com:8010"
    proxy_auth = "83a17a4219d543ef8800965d4293ac5d:"
    urls.each do |s|
      url = s[0]
      tenant_id = s[1]

      puts 'Scraping ' + url
      status = ":FAIL   -   "	# Used as the default

      # Create the request
      c = Curl::Easy.new(url) do |curl|
        curl.proxypwd = proxy_auth
        curl.proxy_url = proxy
        curl.ssl_verify_peer = false  # I ADDED THIS, NOT SECURE
        curl.verbose = false
      end
      # Attempting to fix Curl::Err::PartialFileError: Transferred a partial file
      c.ignore_content_length = true
      c.encoding = 'gzip'
      # Perform request and get body
      c.perform

      # Pull out headers
      http_response, *http_headers = c.header_str.split(/[\r\n]+/).map(&:strip)
      http_headers = Hash[http_headers.flat_map{ |s| s.scan(/^(\S+): (.+)/) }]

      # Check for Crawlera 503 error or 50X errors, and if exist try 5 times (this could be prettier)
      puts http_response
      if http_response.include?('50')
        puts '*** Error 50X ***'
        # Rerun the request up to 4 more times if 503 error
        4.times do
          # Perform request and get body
          c.perform
          # Pull out headers
          http_response, *http_headers = c.header_str.split(/[\r\n]+/).map(&:strip)
          http_headers = Hash[http_headers.flat_map{ |s| s.scan(/^(\S+): (.+)/) }]
          # If no more 503, break out of loop
          if !http_response.include?('50') then break end
        end
      end

      # Pull out body
      page = c.body_str

      # Pull out json variable from page
      subs = page.to_s[/#{"<script>var dataLayer = "}(.*?)#{";</script"}/m, 1]

      # If json variable exists, add it to database
      unless subs.nil?
        j = JSON.parse(subs)
        j["finishes"].each do |f|
          begin
            f["tenant_id"] = tenant_id
          rescue; end
          begin
            f["images_defaultImg"] = f["images"]["defaultImg"]
          rescue; end
          begin
            f["sale_productSaleId"] = f["sale"]["productSaleId"]
          rescue; end
          begin
            f["sale_catchLine"] = f["sale"]["catchLine"]
          rescue; end
          begin
            f["sale_saleDetail"] = f["sale"]["saleDetail"]
          rescue; end
          begin
            f["sale_startDate"] = f["sale"]["startDate"]
          rescue; end
          begin
            f["sale_endDate"] = f["sale"]["endDate"]
          rescue; end
          begin
            f["savingsDetails_standard"] = f["savingsDetails"]["standard"]
          rescue; end
          begin
            f["savingsDetails_total"] = f["savingsDetails"]["total"]
          rescue; end
          begin
            f["savingsDetails_percentage"] = f["savingsDetails"]["percentage"]
          rescue; end
          begin
            f["type_of"] = f["type"]
          rescue; end
          begin
            f["selectedFinish"] = f["finish"]
          rescue; end
          begin
            f.delete("images")
          rescue; end
          begin
            f.delete("sale")
          rescue; end
          begin
            f.delete("savingsDetails")
          rescue; end
          begin
            f.delete("type")
          rescue; end
          begin
            f.delete("finish")
          rescue; end
          begin
            f.delete("upc")
          rescue; end
          begin
            f.delete("iterator")
          rescue; end
          Price.create(site_name: "Build.com", brand: f["manufacturer"], sku: f["sku"], price: f["price"], quantity: f["stock"], tenant_id: f["tenant_id"])
          BuildFinish.create(f)
        end
        status = ":SUCCESS   -   " + "\n"
      end
      puts status
      rnd = rand(1..3)
      puts "Pausing for " + rnd.to_s + " seconds."
      sleep(rnd)
    end
  end

end
