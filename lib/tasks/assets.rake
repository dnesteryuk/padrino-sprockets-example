require 'rake/sprocketstask'

Rake::SprocketsTask.new do |t|
  sprockets = Sprockets::Environment.new

  sprockets.append_path 'app/assets/javascripts'
  sprockets.append_path 'app/assets/stylesheets'
  sprockets.append_path 'app/assets/fonts'

  # any other paths which you need

  sprockets.context_class.class_eval do
    def asset_path(path, options = {})
      path = environment[path].digest_path

      "/assets/#{path}"
    end
  end

  t.environment = sprockets

  t.output = './public/assets'
  t.assets = %w( application.js application.css *.ttf *.woff *.woff2 )
end