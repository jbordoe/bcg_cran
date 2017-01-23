require 'webmock/rspec'

RSpec.describe PackageHandler do
  let(:package_list) {
    "Package: A3
    Version: 1.0.0
    Depends: R (>= 2.15.0), xtable, pbapply
    Suggests: randomForest, e1071
    License: GPL (>= 2)
    NeedsCompilation: no

    Package: abbyyR
    Version: 0.5.0
    Depends: R (>= 3.2.0)
    Imports: httr, XML, curl, readr, progress
    Suggests: testthat, rmarkdown, knitr (>= 1.11)
    License: MIT + file LICENSE
    NeedsCompilation: no

    Package: abc
    Version: 2.1
    Depends: R (>= 2.10), abc.data, nnet, quantreg, MASS, locfit
    License: GPL (>= 3)
    NeedsCompilation: no"
  }

  context '#get_package_list' do
    it 'returns a list of packages' do
      stub_request(:get, "http://cran.r-project.org/src/contrib/PACKAGES").
        to_return(body: package_list)

      package_list = PackageHandler.get_package_list
      expect(package_list).to eq %w{
         A3_1.0.0
         abbyyR_0.5.0
         abc_2.1
      }
    end
  end

  context '#get_package' do
    it 'returns a pacakge object' do
      stub_request(:get, "http://cran.r-project.org/src/contrib/abc_2.1.tar.gz").
        to_return(body: File.read('spec/fixtures/abc_2.1.tar.gz'))

      package = PackageHandler.get_package('abc_2.1')

      expect(package.name).to eq 'abc'
    end
  end

  context '#get_packages' do
    it 'returns a list of package objects' do
      stub_request(:get, "http://cran.r-project.org/src/contrib/PACKAGES").
        to_return(body: package_list)
      stub_request(:get, "http://cran.r-project.org/src/contrib/abc_2.1.tar.gz").
        to_return(body: File.read('spec/fixtures/abc_2.1.tar.gz'))
      stub_request(:get, "http://cran.r-project.org/src/contrib/abbyyR_0.5.0.tar.gz").
        to_return(body: File.read('spec/fixtures/abbyyR_0.5.0.tar.gz'))
      stub_request(:get, "http://cran.r-project.org/src/contrib/A3_1.0.0.tar.gz").
        to_return(body: File.read('spec/fixtures/A3_1.0.0.tar.gz'))

      packages = PackageHandler.get_packages

      expect(packages.map{|p| p.name}).to eq %w{A3 abbyyR abc}
    end
  end
end
