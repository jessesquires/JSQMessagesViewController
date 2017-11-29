module Fastlane
  module Actions
    class PodRepoAddAction < Action
      def self.run(params)
        UI.message "Cleaning up previously added repo with the name: #{params[:repo_name]}"
        remove_command = []
        remove_command << "bundle exec" if params[:use_bundle_exec] && shell_out_should_use_bundle_exec?
        remove_command << "pod repo remove #{params[:repo_name]}"
        begin
          Actions.sh(remove_command.join(' '))
        rescue
          UI.message "Repo does not exists, nothing to do here"
        end
        
        add_command = []
        add_command << "bundle exec" if params[:use_bundle_exec] && shell_out_should_use_bundle_exec?
        add_command << "pod repo add #{params[:repo_name]} #{params[:repo_url]}"
        result = Actions.sh(add_command.join(' '))
        UI.success("Repo added Successfully")
        return result
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "pod repo add"        
      end

      def self.details
        "Adds new Cocoapod podspec repository"
      end

      def self.available_options
        [
                  FastlaneCore::ConfigItem.new(key: :use_bundle_exec,
                                                 description: "Use bundle exec when there is a Gemfile presented",
                                                 is_string: false,
                                                 default_value: true),
                  FastlaneCore::ConfigItem.new(key: :repo_name,
                                                 description: "Cocoapod repo name",
                                                 optional: false,
                                                 is_string: true),
                  FastlaneCore::ConfigItem.new(key: :repo_url,
                                                 description: "Cocoapod repo URL",
                                                 optional: false,
                                                 is_string: true)
        ]        
      end

      def self.output
      end

      def self.return_value
        return nil        
      end

      def self.authors
        ["Aleksander Zubala <aleksander.zubala@ynd-consult.com"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end
    end
  end
end
