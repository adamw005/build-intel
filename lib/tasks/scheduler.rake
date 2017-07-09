desc "Schedule tasks"
task :scrape => :environment do
  SkuUrl.select('distinct url, tenant_id').where.not(url: nil).where.not(url: 'Not Found').shuffle.in_groups_of(100, false).each do |skus|
    urls = []
    skus.each do |s|
      urls.push([s.url, s.tenant_id])
    end
    ScrapeWorker.perform_async(urls)
  end
end

task :search_skus => :environment do
  SkuUrl.where(url: nil).shuffle.in_groups_of(100, false).each do |su|
    ids = []
    su.each do |s|
      ids.push(s.id)
    end
    SearchSkusWorker.perform_async(ids)
  end
end
