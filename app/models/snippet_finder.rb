class SnippetFinder
  class << self
    def find_by_name(name)
      SnippetFile.find_by_name(name) || Snippet.find_by_name(name)
    end
  end
end