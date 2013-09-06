Radiant.config do |config|
  if Radiant.config_definitions(key).nil?
    config.define 'defaults.snippet.filter', :select_from => lambda { TextFilter.descendants.map { |s| s.filter_name }.sort }, :allow_blank => true
  end
end