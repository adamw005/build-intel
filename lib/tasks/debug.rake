
class DBG
  if !defined? COMMON_EXCLUDE
    COMMON_EXCLUDE = %w[id created_at updated_at].freeze
  end

  class << self
    def show(model, attributes_to_exclude: [])
      attribute_names = model.attribute_names.reject do |attrib|
        attributes_to_exclude.include? attrib
      end

      puts attribute_names.join(' ')
      model.all.each do |inst|
        puts(
          attribute_names.map { |attrib| inst.public_send attrib }.join(' ')
        )
      end
      puts

      puts "Count: '#{model.count}'"
      puts
    end
  end
end

namespace :kiq do
  task clear: :environment do
    Sidekiq.redis { |conn| conn.flushdb }
  end
end

namespace :user do
  task create: :environment do
    user = User.new(
      email: 'user@example.org',
      password: 'matzdavid', password_confirmation: 'matzdavid'
    )
    user.skip_confirmation!
    user.save!
  end
end

namespace :skurl do
  task show: :environment do
    DBG.show SkuUrl, attributes_to_exclude: DBG::COMMON_EXCLUDE
  end

  task delete: :environment do
    SkuUrl.delete_all
  end
end

namespace :price do
  task show: :environment do
    DBG.show Price, attributes_to_exclude: DBG::COMMON_EXCLUDE
  end
end

namespace :buildfinish do
  task show: :environment do
    DBG.show BuildFinish, attributes_to_exclude: DBG::COMMON_EXCLUDE
  end
end
