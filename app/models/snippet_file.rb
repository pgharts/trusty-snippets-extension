class SnippetFile < Struct.new(:name, :content)
  class << self
    def find_by_name(name)
      if file(name)
        self.new(name, self.read(name))
      end
    end

    def root
      @root ||= Rails.root.to_s + '/app/templates/snippets/'
    end

    def suffix
      '.radius'
    end

    def file(name)
      files ||= {}
      return files[name] if files[name]
      files[name] = Dir.glob(root + name + suffix).first
    end

    def read(name)
      File.read(file(name))
    end
  end
end