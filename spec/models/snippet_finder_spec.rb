require 'rails_helper'

class TestSnippetFinder; end
class AlternateSnippetFinder; end

describe 'SnippetFinder' do
  it 'finds a snippet by name in the first finder type' do
    allow(SnippetFinder).to receive(:finder_types) {[TestSnippetFinder, AlternateSnippetFinder]}
    allow(TestSnippetFinder).to receive(:find_by_name) {OpenStruct.new(:name => 'test_snippet')}

    SnippetFinder.find_by_name('test_snippet')
  end

  it 'finds a snippet by name in the next finder type after no result from the previous' do
    allow(SnippetFinder).to receive(:finder_types) {[TestSnippetFinder, AlternateSnippetFinder]}
    allow(TestSnippetFinder).to receive(:find_by_name) {nil}
    allow(AlternateSnippetFinder).to receive(:find_by_name) {OpenStruct.new(:name => 'alternate_snippet')}

    SnippetFinder.find_by_name('alternate_snippet')
  end
end