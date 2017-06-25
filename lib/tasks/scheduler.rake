desc "Schedule tasks"
task :scrape => :environment do
  puts "Beginning Scrape..."

	status_count_success = 0
	status_count_total = 0

  proxy = "proxy.crawlera.com:8010"
  proxy_auth = "83a17a4219d543ef8800965d4293ac5d:"

  # For each record in SkuUrl where url is not nil, scrape the url
	SkuUrl.where.not(url: !nil).shuffle.each do |s|
    puts s.manuf + ' -- ' + s.sku
    url = s.url
		status = ":FAIL   -   "	# Used as the default

    # Create the request
    c = Curl::Easy.new(url) do |curl|
      curl.proxypwd = proxy_auth
      curl.proxy_url = proxy
      curl.ssl_verify_peer = false  # I ADDED THIS, NOT SECURE
      curl.verbose = false
    end

    # Perform request and get body
    c.perform
    page = c.body_str

    # Pull out json variable from page
		subs = page.to_s[/#{"<script>var dataLayer = "}(.*?)#{";</script"}/m, 1]

    # If json variable exists, add it to database
		unless subs.nil?
      j = JSON.parse(subs)
			j["finishes"].each do |f|
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
				BuildFinish.create(f)
			end
			status_count_success += 1
			status = ":SUCCESS   -   " + 	status_count_success.to_s + "/" + (status_count_total+1).to_s + "\n"
		end
		status_count_total += 1
		puts status
		rnd = rand(3..12)
		puts "Pausing for " + rnd.to_s + " seconds."
		sleep(rnd)
	end
  puts "Finished Scraping."
end


desc "Schedule tasks"
task :curbtest => :environment do
  puts "Beginning test..."

  url = "https://twitter.com"
  proxy = "proxy.crawlera.com:8010"
  proxy_auth = "83a17a4219d543ef8800965d4293ac5d"

  c = Curl::Easy.new(url) do |curl|
    curl.proxypwd = proxy_auth
    curl.proxy_url = proxy
    curl.ssl_verify_peer = false  # I ADDED THIS, NOT SECURE
    curl.verbose = true
  end

  c.perform
  puts c.body_str
end




task :search_skus => :environment do
  puts "Starting.."
  proxy = "proxy.crawlera.com:8010"
  proxy_auth = "83a17a4219d543ef8800965d4293ac5d:"

  SkuUrl.where(url: nil).each do |s|
    # Create the Search URL using the Manufacturer and SKU for records without a URL
    search_url = 'https://www.build.com/index.cfm?page=search%3Abrowse&term=' + s.manuf + '+' + s.sku
    puts 'Search URL: ' + search_url

    # Create the Request
    c = Curl::Easy.new(search_url) do |curl|
      curl.proxypwd = proxy_auth
      curl.proxy_url = proxy
      curl.ssl_verify_peer = false  # I ADDED THIS, NOT SECURE
      curl.verbose = false
    end

    # Perform the Request, parse the headers, and parse the page
    c.perform
    # Parse the headers with HttpHeaders
    headers = HttpHeaders.new(c.header_str)
    # Parse body with Nokogiri
    page = c.body_str
    html_doc = Nokogiri::HTML(page)

    # If redirect (meaning only 1 search result), use the redirect url as the product url
    if headers.location
      s.url = 'https://www.build.com' + headers.location.split(/\?/).first
      s.save
      puts s.manuf + ' -- ' + s.sku + ': ' + s.url
    # For each Search Result, store that URL with Manufacturer and SKU, and if >0 URLs found destroy old record
    else
      new_records = 0
      html_doc.css("a.product-link").each do |p|
        url = 'https://www.build.com' + p["href"].split(/\?/).first
        SkuUrl.create(manuf: s.manuf, sku: s.sku, url: url)
        puts s.manuf + ' -- ' + s.sku + ': ' + url
        new_records += 1
      end
      if new_records != 0 then s.destroy end
    end
  end
  puts 'Finished.'

end
