require File.expand_path(File.dirname(__FILE__) + '/../snippets_spec_helper.rb')

class TestSnippetFinder; end
class AlternateSnippetFinder; end

describe 'SnippetFinder' do
  it 'finds a snippet by name in the first finder type' do
    SnippetFinder.stub!(:finder_types).and_return([TestSnippetFinder, AlternateSnippetFinder])
    TestSnippetFinder.should_receive(:find_by_name).and_return(OpenStruct.new(:name => 'test_snippet'))
    
    SnippetFinder.find_by_name('test_snippet')
  end
  it 'finds a snippet by name in the next finder type after no result from the previous' do
    SnippetFinder.stub!(:finder_types).and_return([TestSnippetFinder, AlternateSnippetFinder])
    TestSnippetFinder.stub!(:find_by_name).and_return(nil)
    AlternateSnippetFinder.should_receive(:find_by_name).and_return(OpenStruct.new(:name => 'alternate_snippet'))

    SnippetFinder.find_by_name('alternate_snippet')
  end
end