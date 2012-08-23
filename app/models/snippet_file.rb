class SnippetFile < Struct.new(:name, :content)
  class << self
    def find_by_name(name)
      if file(name)
        self.new(name, self.read(name))
      end
    end

    def root
      @root ||= Rails.root.to_s + '/app/templates/snippets'
    end

    def suffix
      '.radius'
    end

    def path(name)
      [root, '/', name, suffix].join('')
    end

    def file(name, collection=Dir.glob(path(name)))
      return files[name] if files[name]
      files[name] = collection.first
    end

    def files
      @files ||= {}
    end

    def read(name, reader=File)
      reader.read(file(name))
    end
  end
end