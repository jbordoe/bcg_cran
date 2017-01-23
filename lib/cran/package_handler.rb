require 'rubygems/package'
require 'dcf'

class PackageHandler

  CRAN_ROOT_URL = 'http://cran.r-project.org/src/contrib'
  PACKAGE_LIST_URL = "#{CRAN_ROOT_URL}/PACKAGES"

  def self.get_packages(limit = 0)
    package_names = get_package_list

    package_names = package_names[0..limit] if limit > 0
    packages = package_names.map{|p| 
      begin
        get_package(p)
      rescue
        nil
      end
    }
    packages.select{|e| !e.nil?}
  end

  def self.get_package(name)
    conn = Faraday.new do |builder|
      builder.adapter Faraday.default_adapter 
    end
    package_url = "#{CRAN_ROOT_URL}/#{name}.tar.gz"
    response = conn.get package_url

    dir = Dir.mktmpdir
    tmpfilename = "#{dir}/#{name}.tar.gz"
    File.open(tmpfilename, 'wb') {|path| path.write(response.body) }

    uncompressed = Gem::Package::TarReader.new(Zlib::GzipReader.open(tmpfilename))
    description = uncompressed.detect do |f|
      f.full_name =~ /\/DESCRIPTION$/
    end.read
    
    package_data = Dcf.parse(description)[0]
    Package.new(
      name: package_data['Package'],
      version: package_data['Version'],
      date: DateTime.parse(package_data['Date/Publication']),
      description: package_data['Description'],
      authors: package_data['Author'].gsub(/\s\[.*?\]/, ''),
      maintainer: package_data['Maintainer']
    )
  end

  def self.get_package_list
    conn = Faraday.new(:url => PACKAGE_LIST_URL)
    response = conn.get

    parse_package_list(response.body)
  end
  
  private

  def self.parse_package_list(raw)
    packages = raw.split(/^\n/)

    packages.map{|p| parse_package_chunk(p)}
  end

  def self.parse_package_chunk(raw)
    package_name = raw.match(/Package: (\w+)/)[1]
    package_version = raw.match(/Version: ([^\n]+)/)[1]

    [package_name, package_version].join('_')
  end
end
