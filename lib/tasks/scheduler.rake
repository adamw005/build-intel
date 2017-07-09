desc "Schedule tasks"
task :scrape => :environment do
  SkuUrl.select('distinct url').where.not(url: nil).where.not(url: 'Not Found').shuffle.in_groups_of(100, false).each do |skus|
    urls = []
    skus.each do |s|
      urls.push(s.url)
    end
    ScrapeWorker.perform_async(urls)
  end
end

# TODO: use `in_groups_of` for this as well
task :search_skus => :environment do
  SkuUrl.where(url: nil).each do |s|
    SearchSkusWorker.perform_async(s.id)
  end
end
