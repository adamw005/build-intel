desc "Schedule tasks"
task :scrape => :environment do
  puts "Beginning Scrape..."

	page = MetaInspector.new("https://www.build.com/wac-lighting-wl-led100-c/s752331?uid=2277216")
	j = JSON.parse(page.to_s[/#{"<script>var dataLayer = "}(.*?)#{";</script"}/m, 1])
	puts j["finishes"]
	
  puts "done."
end
