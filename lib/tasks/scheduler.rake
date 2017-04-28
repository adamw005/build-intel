desc "Schedule tasks"
task :scrape => :environment do
  puts "Beginning Scrape..."

	page = MetaInspector.new("https://www.build.com/wac-lighting-wl-led100-c/s752331?uid=2277216")
	j = JSON.parse(page.to_s[/#{"<script>var dataLayer = "}(.*?)#{";</script"}/m, 1])
	j["finishes"].each do |f|
		puts f
		f["images_defaultImg"] = f["images"]["defaultImg"]
		f["sale_productSaleId"] = f["sale"]["productSaleId"]
		f["sale_catchLine"] = f["sale"]["catchLine"]
		f["sale_saleDetail"] = f["sale"]["saleDetail"]
		f["sale_startDate"] = f["sale"]["startDate"]
		f["sale_endDate"] = f["sale"]["endDate"]
		f["savingsDetails_standard"] = f["savingsDetails"]["standard"]
		f["savingsDetails_total"] = f["savingsDetails"]["total"]
		f["savingsDetails_percentage"] = f["savingsDetails"]["percentage"]
		f["type_of"] = f["type"]
		f.delete("images")
		f.delete("sale")
		f.delete("savingsDetails")
		f.delete("type")
		BuildFinish.create(f)
		end

  puts "done."
	end

end
