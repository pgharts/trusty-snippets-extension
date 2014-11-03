# Uncomment this if you reference any of your controllers in activate
# require_dependency "application_controller"
require "trusty-snippets-extension"

class SnippetsExtension < TrustyCms::Extension
  version     TrustySnippetsExtension::VERSION
  description TrustySnippetsExtension::DESCRIPTION
  url         TrustySnippetsExtension::URL

  def activate
    
    if defined?(Radiant::Exporter)
      TrustyCms::Exporter.exportable_models << Snippet
      TrustyCms::Exporter.template_models << Snippet
    end
    
    Page.class_eval do
      include SnippetTags
    end

    TrustyCms::AdminUI.class_eval do
      attr_accessor :snippet

      alias_method :snippets, :snippet

      def load_default_snippet_regions
        OpenStruct.new.tap do |snippet|
          snippet.edit = TrustyCms::AdminUI::RegionSet.new do |edit|
            edit.main.concat %w{edit_header edit_form}
            edit.form.concat %w{edit_title edit_content edit_filter}
            edit.form_bottom.concat %w{edit_buttons edit_timestamp}
          end
          snippet.index = TrustyCms::AdminUI::RegionSet.new do |index|
            index.top.concat %w{}
            index.thead.concat %w{title_header actions_header}
            index.tbody.concat %w{title_cell actions_cell}
            index.bottom.concat %w{new_button}
          end
          snippet.new = snippet.edit
        end
      end

      def load_default_snippet_file_regions
        OpenStruct.new.tap do |snippet|
          snippet.show = TrustyCms::AdminUI::RegionSet.new do |edit|
            edit.main.concat %w{ header }
            edit.display_content.concat %w{ title content }
            edit.bottom.concat %w{ timestamp }
          end
          snippet.index = TrustyCms::AdminUI::RegionSet.new do |index|
            index.top.concat %w{}
            index.thead.concat %w{title_header}
            index.tbody.concat %w{title_cell}
            index.bottom.concat %w{new_button}
          end
        end
      end
    end
    
    admin.snippet       ||= TrustyCms::AdminUI.load_default_snippet_regions
    
    UserActionObserver.instance.send :add_observer!, ::Snippet
                                 
    tab 'Design' do
      add_item "Snippets", "/admin/snippets"
    end
    
  end
end
