class SnippetFile < Struct.new(:name, :content)
  class << self
    def find_by_name(name)
      if file(name)
        self.new(name, self.read(name))
      end
    end
    alias find find_by_name

    def all
      Dir.glob([root, '/','*',suffix].join('')).collect{ |file_path|
        name = File.basename(file_path, suffix)
        content = File.read(file_path)
        self.new(name, content)
      }
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
      @files ||= {}
      return @files[name] if @files[name]
      @files[name] = collection.first
    end

    def read(name, reader=File)
      reader.read(file(name))
    end
  end

  def to_param
    name
  end

  def updated_at
    time = File.mtime(self.class.file(name))
    I18n.localize(time, :format => :timestamp)
  end
end