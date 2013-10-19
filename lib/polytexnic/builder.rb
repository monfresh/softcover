module Polytexnic
  class Builder
    include Polytexnic::Utils

    attr_accessor :manifest, :built_files

    def initialize
      @manifest = Polytexnic::BookManifest.new(verify_paths: true,
                                               source: source)
      @built_files = []
    end

    def build!
      write_polytexnic_commands_file
      setup
      build
      verify
      self
    end

    def clean!; end

    private
      def setup; end
      def verify; end

      def source
        markdown_directory? ? :markdown : :polytex
      end

      # Writes out the PolyTeXnic commands from polytexnic-core.
      def write_polytexnic_commands_file
        Polytexnic::Core.write_polytexnic_style_file(Dir.pwd)
      end
  end
end