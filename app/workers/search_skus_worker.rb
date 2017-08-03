require 'curb'

class SearchSkusWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(ids)
    ids.each do |id|
      s = SkuUrl.find(id)
      puts "Starting.."
      proxy = "proxy.crawlera.com:8010"
      proxy_auth = "83a17a4219d543ef8800965d4293ac5d:"

      # Create the Search URL using the Manufacturer and SKU for records without a URL
      search_url = 'https://www.build.com/index.cfm?page=search%3Abrowse&term=' + s.manuf + '+' + s.sku
      puts 'Search URL: ' + search_url

      # Create the Request
      c = Curl::Easy.new(search_url) do |curl|
        # ...
        curl.proxypwd = proxy_auth
        curl.proxy_url = proxy
        curl.timeout = 60

        curl.ssl_verify_peer = false  # I ADDED THIS, NOT SECURE
        curl.verbose = false
      end

      # Attempting to fix Curl::Err::PartialFileError: Transferred a partial file
      c.ignore_content_length = true
      c.encoding = 'gzip'
      # Perform the Request, parse the headers, and parse the page

      # ...
      begin
        c.perform
      rescue Curl::Err::TimeoutError => exc
        warn exc
      end
      # c.perform

      # Parse the headers with HttpHeaders
      headers = HttpHeaders.new(c.header_str)
      # Parse body with Nokogiri
      page = c.body_str
      html_doc = Nokogiri::HTML(page)

      # If redirect (meaning only 1 search result), use the redirect url as the product url
      if headers.location
        puts ' -Redirect'
        s.url = 'https://www.build.com' + headers.location.split(/\?/).first
        s.save
        puts s.manuf + ' -- ' + s.sku + ': ' + s.url
      # For each Search Result, store that URL with Manufacturer and SKU, and if >0 URLs found destroy old record
      else
        new_records = 0
        html_doc.css("a.product-link").each do |p|
          url = 'https://www.build.com' + p["href"].split(/\?/).first
          SkuUrl.create(manuf: s.manuf, sku: s.sku, url: url)
          new_records += 1
        end
        if new_records != 0
          puts ' -Search Page'
          puts s.manuf + ' -- ' + s.sku
          s.destroy
        else
          puts ' -SKU Not Found'

          # # ...
          s.url = 'Not Found'
          s.save
        end
      end
    end
  end

end
