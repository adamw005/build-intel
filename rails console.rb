
Price.select("brand, sku, avg(price) as price").group("brand").group("sku")
.joins("left join prices b on prices.brand = b.brand and prices.sku = b.sku").select("brand, sku, price")

sql="
select a.brand, a.sku, avg(a.price) as avg_price, b.current_price
from prices a
left join (
select x.brand, x.sku, x.price as current_price
from prices x
left join prices y
 on x.brand = y.brand and x.sku = y.sku and x.created_at < y.created_at
where y.created_at IS NULL
) b
on a.brand = b.brand and a.sku = b.sku
group by 1,2,4
"
x = Price.select("*").from("(#{sql}) as subquery")
x.first
x.first.avg_price


select.('a.brand, a.sku, avg(a.price) as avg_price, b.current_price').from('prices a').joins('left join (
select x.brand, x.sku, x.price as current_price
from prices x
left join prices y on x.brand = y.brand and x.sku = y.sku and x.created_at < y.created_at)
where y.created_at IS NULL
) b on a.brand = b.brand and a.sku = b.sku
group by 1,2,4')


urls = []
# SkuUrl.where.not(url: nil).where.not(url: 'Not Found').distinct.shuffle.in_groups_of(100, false).each do |skus|
SkuUrl.select('distinct url').where.not(url: nil).where.not(url: 'Not Found').shuffle.in_groups_of(100, false).each do |skus|
skus.each do |s|
urls.push(s.url)
end
end

SkuUrl.where.not(url: nil).where.not(url: 'Not Found').distinct.shuffle.in_groups_of(100, false).each do |skus|
@ss += 1
end
puts @ss
SkuUrl.select('distinct url').where.not(url: nil).where.not(url: 'Not Found').shuffle.in_groups_of(100, false).each do |skus|
end


RestClient.post "https://api:key-f555382b02700bc449dd1ef9da9aabf0" "@api.mailgun.net/v3/sandbox7d6743916360441e9c7a401ad39fd8e2.mailgun.org/messages", :from => "Mailgun Sandbox <postmaster@sandbox7d6743916360441e9c7a401ad39fd8e2.mailgun.org>", :to => "Adam <adamwinn99@gmail.com>", :subject => "Hello Adam", :text => "Congratulations Adam, you just sent an email with Mailgun!  You are truly awesome!"


proxy = "proxy.crawlera.com:8010"
proxy_auth = "83a17a4219d543ef8800965d4293ac5d:"
s = SkuUrl.first
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

http_response, *http_headers = c.header_str.split(/[\r\n]+/).map(&:strip)
http_headers = Hash[http_headers.flat_map{ |s| s.scan(/^(\S+): (.+)/) }]


if http_response.include?('20')
# Rerun the request up to 4 more times if 503 error
4.times do
puts 'working'
# Perform request and get body
c.perform
# Pull out headers
http_response, *http_headers = c.header_str.split(/[\r\n]+/).map(&:strip)
http_headers = Hash[http_headers.flat_map{ |s| s.scan(/^(\S+): (.+)/) }]
# If no more 503, break out of loop
if !http_headers['X-Crawlera-Next-Request-In'] || !http_response.include?('20') then break end
end
end














SkuUrl.all.each do |s|
s.destroy
end
SkuUrl.create(manuf: 'Waterstone', sku: '5600')
SkuUrl.create(manuf: 'Waterstone', sku: '1100-C01')

SkuUrl.where.not(url: nil).where.not(url: 'Not Found').count
SkuUrl.where(url: 'Not Found').count
SkuUrl.where(url: nil).count


SkuUrl.where.not(url: nil).where.not(url: 'Not Found').distinct.shuffle.in_groups_of(100,false).each do |skus|
urls = []
skus.each do |s|
puts s.url
end
end





urls = ["https://www.build.com/delta-9178t/s1082158", "https://www.build.com/miseno-mk381/s1183672", "https://www.build.com/miseno-mk003/s1181155", "https://www.build.com/miseno-mk331/s1183671", "https://www.build.com/miseno-mk281/s1084763", "https://www.build.com/miseno-mk621/s1183673", "https://www.build.com/grohe-30-271/s1160239", "https://www.build.com/grohe-31-401/s1142565", "https://www.build.com/miseno-mk121/s1183670", "https://www.build.com/hansgrohe-06801/s25818", "https://www.build.com/brizo-63225lf/s1123651", "https://www.build.com/danze-d401157/s1192734", "https://www.build.com/delta-9113-dst/s1136292", "https://www.build.com/delta-9659-dst/s1236721", "https://www.build.com/delta-9913-dst/s1136294", "https://www.build.com/kraus-kpf-2730/s1159554", "https://www.build.com/kraus-kpf-1660/s1159544", "https://www.build.com/kohler-k-99260/s1220223", "https://www.build.com/delta-4140-dst/s1246866", "https://www.build.com/delta-9659t-dst/s1236733", "https://www.build.com/delta-9113t-dst/s1136293", "https://www.build.com/delta-9183t-dst/s1178244", "https://www.build.com/moen-5965-bar-faucet/s857095", "https://www.build.com/moen-5923/s1202286?uid=2876305", "https://www.build.com/delta-1177lf-pot-filler/s65773", "https://www.build.com/insinkerator-h-hot100/s1128354", "https://www.build.com/delta-9678-bar-faucet/s1080237", "https://www.build.com/delta-1997lf-bar-faucet/s782664", "https://www.build.com/kohler-k-597-bar-faucet/s563680", "https://www.build.com/delta-1165lf-pot-filler/s1054247", "https://www.build.com/delta-1959lf-bar-faucet/s1064259", "https://www.build.com/miseno-mk351/s1212118?uid=2900964", "https://www.build.com/miseno-mk601/s1144273?uid=2738842", "https://www.build.com/delta-9959-dst-bar-faucet/s409437", "https://www.build.com/miseno-mk052/s1181158?uid=2894446", "https://www.build.com/delta-9997-dst-bar-faucet/s782668", "https://www.build.com/brizo-63221lf/s1136291?uid=2726476", "https://www.build.com/kraus-kpf-1650/s578079?uid=2771098", "https://www.build.com/american-standard-4931380/s1230960", "https://www.build.com/miseno-mk500-kitchen-faucet/s920157", "https://www.build.com/grohe-32-665-kitchen-faucet/s163597", "https://www.build.com/delta-9181-dst/s1277398?uid=3037970", "https://www.build.com/kraus-kpf-2630/s1159550?uid=2771096", "https://www.build.com/delta-9183-dst/s1178243?uid=2820505", "https://www.build.com/kohler-k-99261/s1087924?uid=2612773", "https://www.build.com/kohler-k-99259/s1087923?uid=2612769", "https://www.build.com/kraus-kpf-2620/s1159548?uid=2771074", "https://www.build.com/kohler-k-77515/s1257977?uid=3008865", "https://www.build.com/vigo-vg02001-kitchen-faucet/s741449", "https://www.build.com/grohe-32-319-kitchen-faucet/s169011", "https://www.build.com/grohe-30-211-kitchen-faucet/s941004", "https://www.build.com/grohe-32-951-kitchen-faucet/s166139", "https://www.build.com/hansgrohe-4215-kitchen-faucet/s17854", "https://www.build.com/kohler-k-7505-kitchen-faucet/s565761", "https://www.build.com/delta-9159-dst-kitchen-faucet/s380199", "https://www.build.com/delta-9178-dst-kitchen-faucet/s380933", "https://www.build.com/delta-9197-dst-kitchen-faucet/s782666", "https://www.build.com/delta-4197-dst-kitchen-faucet/s856516", "https://www.build.com/brizo-63025lf-kitchen-faucet/s1061379", "https://www.build.com/grohe-32-298-1-kitchen-faucet/s900521", "https://www.build.com/rohl-u-4719l-2-kitchen-faucet/s735768", "https://www.build.com/kraus-kpf-1612-kitchen-faucet/s578004", "https://www.build.com/grohe-33-755-1-kitchen-faucet/s900522", "https://www.build.com/delta-9192-dst-kitchen-faucet/s381277", "https://www.build.com/kohler-k-15160-kitchen-faucet/s559998", "https://www.build.com/elkay-lkec2037-kitchen-faucet/s586936", "https://www.build.com/kohler-k-13963-kitchen-faucet/s559666", "https://www.build.com/kohler-k-72218-kitchen-faucet/s821911", "https://www.build.com/delta-4159-dst-kitchen-faucet/s872252", "https://www.build.com/delta-4153-dst-kitchen-faucet/s196382", "https://www.build.com/delta-9159t-dst-kitchen-faucet/s380346", "https://www.build.com/delta-9197t-dst-kitchen-faucet/s782667", "https://www.build.com/pfister-g133-10-kitchen-faucet/s524938", "https://www.build.com/delta-9192t-dst-kitchen-faucet/s382363", "https://www.build.com/rohl-a1458lmws-2-kitchen-faucet/s413414", "https://www.build.com/kohler-k-15160-l-kitchen-faucet/s559799", "https://www.build.com/moen-5995-bar-faucet/s264985?uid=1959095", "https://www.build.com/moen-5985-bar-faucet/s264904?uid=2306794", "https://www.build.com/kingston-brass-ks310-al-pot-filler/s578666", "https://www.build.com/moen-7594-kitchen-faucet/s326837?uid=1959099", "https://www.build.com/moen-7185-kitchen-faucet/s316149?uid=2306737", "https://www.build.com/moen-7545-kitchen-faucet/s326162?uid=1866896", "https://www.build.com/moen-7565-kitchen-faucet/s857097?uid=2195167", "https://www.build.com/moen-7594e-kitchen-faucet/s332050?uid=1945034", "https://www.build.com/moen-87017-kitchen-faucet/s943462?uid=2542408", "https://www.build.com/kohler-k-596-kitchen-faucet/s563679?uid=1770065", "https://www.build.com/miseno-mk171-kitchen-faucet/s920156?uid=2306767", "https://www.build.com/kohler-k-560-kitchen-faucet/s562706?uid=1740832", "https://www.build.com/grohe-31-380-kitchen-faucet/s882828?uid=2243903", "https://www.build.com/grohe-32-999-kitchen-faucet/s163605?uid=1593600", "https://www.build.com/kohler-k-10433-kitchen-faucet/s557536?uid=155220", "https://www.build.com/kingston-brass-ks127-albs-kitchen-faucet/s578161", "https://www.build.com/american-standard-2475-500f15-bar-faucet/s130641", "https://www.build.com/kraus-kpf-1602-kitchen-faucet/s578069?uid=1755948", "https://www.build.com/kraus-kpf-2230-kitchen-faucet/s578015?uid=1795127", "https://www.build.com/insinkerator-f-gn1100-hot-water-dispenser/s503236", "https://www.build.com/insinkerator-f-hc3300-hot-water-dispenser/s503142", "https://www.build.com/insinkerator-f-hc1100-hot-water-dispenser/s503238", "https://www.build.com/newport-brass-106c-water-dispenser/s58425?uid=26182", "https://www.build.com/newport-brass-1500-5103-kitchen-faucet/s821554?uid=2117471"
]









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
