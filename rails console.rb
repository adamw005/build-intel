proxy = "proxy.crawlera.com:8010"
proxy_auth = "83a17a4219d543ef8800965d4293ac5d:"
s = SkuUrl.last
search_url = 'https://www.build.com/index.cfm?page=search%3Abrowse&term=' + s.manuf + '+' + s.sku
c = Curl::Easy.new(search_url) do |curl|
curl.proxypwd = proxy_auth
curl.proxy_url = proxy
curl.ssl_verify_peer = false  # I ADDED THIS, NOT SECURE
curl.verbose = false
end
c.perform
headers = HttpHeaders.new(c.header_str)
puts headers.location


















conf.echo = false
urls = ["https://www.build.com/delta-9178t/s1082158", "https://www.build.com/miseno-mk381/s1183672", "https://www.build.com/miseno-mk003/s1181155", "https://www.build.com/miseno-mk331/s1183671", "https://www.build.com/miseno-mk281/s1084763", "https://www.build.com/miseno-mk621/s1183673", "https://www.build.com/grohe-30-271/s1160239", "https://www.build.com/grohe-31-401/s1142565", "https://www.build.com/miseno-mk121/s1183670", "https://www.build.com/hansgrohe-06801/s25818", "https://www.build.com/brizo-63225lf/s1123651", "https://www.build.com/danze-d401157/s1192734", "https://www.build.com/delta-9113-dst/s1136292", "https://www.build.com/delta-9659-dst/s1236721", "https://www.build.com/delta-9913-dst/s1136294", "https://www.build.com/kraus-kpf-2730/s1159554", "https://www.build.com/kraus-kpf-1660/s1159544", "https://www.build.com/kohler-k-99260/s1220223", "https://www.build.com/delta-4140-dst/s1246866", "https://www.build.com/delta-9659t-dst/s1236733"]

url = "https://www.build.com/delta-9178t/s1082158"





subs = page.to_s[/#{"<script>var dataLayer = "}(.*?)#{";</script"}/m, 1]

urls = ["https://www.build.com/dreamline-d32372r/s1281970",
"https://www.build.com/meyda-tiffany-14475/s81540",
"https://www.build.com/meyda-tiffany-27562/s142695",
"https://www.build.com/swarovski-blossom-cpbu165/s1235851",
"https://www.build.com/brewster-src194528/s1138803",
"https://www.build.com/marmont-hill-girl-at-the-mirror/s1177529",
"https://www.build.com/mohawk-industries-mqnd-01682/s1007711"]
urls.shuffle.each do |url|
agent = UserAgents.rand()
page = MetaInspector.new(url, :headers => {'User-Agent' => agent})
puts page.to_s[0..750]
rnd = rand(15..22)
puts "Pausing for " + rnd.to_s + " seconds."
sleep(rnd)
end


agent = Mechanize.new
page = agent.get("https://www.build.com/dreamline-d32372r/s1281970")
/distil_r_captcha.html?requestId=ece2afe4-8d4b-4fc2-8449-ea6ed5078300&httpReferrer=%2Fdelta-9178t%2Fs1082158


require "uri"
require "net/http"
