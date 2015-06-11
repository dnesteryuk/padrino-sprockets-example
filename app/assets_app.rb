require 'sprockets'
require 'ejs'

module PsExample
  class Assets
    def initialize
      @sprockets = Sprockets::Environment.new
      @sprockets.append_path 'app/assets/javascripts'
      @sprockets.append_path 'app/assets/stylesheets'
      @sprockets.append_path 'app/assets/fonts'

      # any other paths which you need here

      @sprockets.context_class.class_eval do
        def asset_path(path, options = {})
          "/assets/#{path}"
        end
      end
    end

    def call(*args)
      @sprockets.call(*args)
    end

    def self.root
      Padrino.root('public')
    end

    def self.call(*args)
      new.call(*args)
    end
  end
end