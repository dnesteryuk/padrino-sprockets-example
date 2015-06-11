module PsExample
  class App
    module AssetTagsHelper
      def js_include_tag(*sources)
        options = sources.extract_options!.symbolize_keys
        options.reverse_merge!(type: 'text/javascript')
        sources.flatten.map { |source|
          content_tag(
            :script,
            nil,
            options.reverse_merge(
              src: resolve_path(source.to_s)
            )
          )
        }.join("\n").html_safe
      end

      def css_link_tag(*sources)
        options = sources.extract_options!.symbolize_keys
        options.reverse_merge!(media: 'screen', rel: 'stylesheet', type: 'text/css')
        sources.flatten.map { |source|
          tag(
            :link,
            options.reverse_merge(
              href: asset_path(:css, resolve_path(source.to_s))
            )
          )
        }.join("\n").html_safe
      end

      protected
        def resolve_path(source)
          if Padrino.env == :production
            minifest_file = Sprockets::ManifestUtils.find_directory_manifest(
              Padrino.root('public/assets')
            )

            manifest = Sprockets::Manifest.new(
              Sprockets::Environment.new,
              minifest_file
            )

            '/assets/' + manifest.assets[source]
          else
            asset_path('/assets/' + source)
          end
        end
    end

    helpers AssetTagsHelper
  end
end