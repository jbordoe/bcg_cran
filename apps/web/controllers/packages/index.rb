module Web::Controllers::Packages
  class Index
    include Web::Action

    expose :packages
    def call(params)
      @packages = PackageRepository.new.all
    end
  end
end
