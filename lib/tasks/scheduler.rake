desc "Schedule tasks"
task :scrape => :environment do
  SkuUrl.where.not(url: nil).where.not(url: 'Not Found').distinct.shuffle.in_groups_of(100, false).each do |skus|
    urls = []
    skus.each do |s|
      urls.push(s.url)
    end
    ScrapeWorker.perform_async(urls)
  end
end


task :search_skus => :environment do
  SkuUrl.where(url: nil).each do |s|
    SearchSkusWorker.perform_async(s.id)
  end
end
