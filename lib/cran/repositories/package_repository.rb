class PackageRepository < Hanami::Repository
  def find_package(name, version)
    packages.where(name: name, version: version).first
  end
end
