conf.echo = false
urls = ["https://www.build.com/delta-9178t/s1082158", "https://www.build.com/miseno-mk381/s1183672", "https://www.build.com/miseno-mk003/s1181155", "https://www.build.com/miseno-mk331/s1183671", "https://www.build.com/miseno-mk281/s1084763", "https://www.build.com/miseno-mk621/s1183673", "https://www.build.com/grohe-30-271/s1160239", "https://www.build.com/grohe-31-401/s1142565", "https://www.build.com/miseno-mk121/s1183670", "https://www.build.com/hansgrohe-06801/s25818", "https://www.build.com/brizo-63225lf/s1123651", "https://www.build.com/danze-d401157/s1192734", "https://www.build.com/delta-9113-dst/s1136292", "https://www.build.com/delta-9659-dst/s1236721", "https://www.build.com/delta-9913-dst/s1136294", "https://www.build.com/kraus-kpf-2730/s1159554", "https://www.build.com/kraus-kpf-1660/s1159544", "https://www.build.com/kohler-k-99260/s1220223", "https://www.build.com/delta-4140-dst/s1246866", "https://www.build.com/delta-9659t-dst/s1236733"]

urls = ["https://www.build.com/delta-9178t/s1082158"]

urls.shuffle.each do |url|
agent = UserAgents.rand()
page = MetaInspector.new(url, :headers => {'User-Agent' => agent})
puts page.response.status
puts page.response.headers
puts page.to_s[/#{"<script>var dataLayer = "}(.*?)#{";</script"}/m, 1]

end



subs = page.to_s[/#{"<script>var dataLayer = "}(.*?)#{";</script"}/m, 1]
