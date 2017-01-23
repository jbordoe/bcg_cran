require 'rake'
require 'hanami/rake_tasks'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end

task update_packages: :environment do

  limit = 50
  repo = PackageRepository.new
  packages = PackageHandler.get_packages(limit)
  packages.each do |p|
    match = repo.find_package(p.name, p.version)
    if (match)
      repo.update(match.id, p)
    else
      repo.create(p)
    end
  end
end
