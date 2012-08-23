class SnippetFinder
  class << self
    def find_by_name(name)
      finder_types.find{|type|
        found = type.find_by_name(name)
        return found if found
      }
    end

    def finder_types
      [SnippetFile, Snippet]
    end
  end
end