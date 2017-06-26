desc "Schedule tasks"
task :scrape => :environment do
  SkuUrl.where.not(url: nil).where.not(url: 'Not Found').distinct.shuffle.each do |s|
    ScrapeWorker.perform_async(s.url)
  end
end


task :search_skus => :environment do
  SkuUrl.where(url: nil).each do |s|
    SearchSkusWorker.perform_async(s.id)
  end
end
