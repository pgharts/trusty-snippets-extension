class Admin::SnippetFilesController < Admin::ResourceController
  def show;end
  private
  def load_models
    SnippetFile.all
  end
end