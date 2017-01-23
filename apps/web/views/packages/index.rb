module Web::Views::Packages
  class Index
    include Web::View

    def package_text(package)
      raw "<b>#{package.name}</b> v#{package.version}"
    end
  end
end
