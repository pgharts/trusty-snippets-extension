require File.expand_path(File.dirname(__FILE__) + '/../snippets_spec_helper.rb')

describe SnippetFile do

  let(:fixture_file){ 
    spec_directory_path = File.expand_path(File.dirname(__FILE__))
    fixture_directory_path = spec_directory_path + "/fixtures"
    Dir.glob(fixture_directory_path + 'snippet_template.radius').first
  }

  it 'has a root in the Rails path' do
    SnippetFile.root.should == Rails.root.to_s + '/app/templates/snippets'
  end

  it 'has a file suffix' do
    SnippetFile.suffix.should == '.radius'
  end

  it "returns a snippet file from the found file" do
    mock_file = OpenStruct.new(:name => 'snippet_template')
    SnippetFile.stub!(:file).with('snippet_template').and_return(mock_file)
    SnippetFile.stub!(:read).with('snippet_template').and_return('content')
    SnippetFile.find_by_name('snippet_template').should be_a(SnippetFile)
  end

  it 'has a file found by name' do
    SnippetFile.file(name).should == fixture_file
  end

  it 'returns contents of a named snippet file' do
    reader = mock('reader')
    reader.stub!(:read).and_return('content')
    SnippetFile.read(name, reader).should == 'content'
  end
end