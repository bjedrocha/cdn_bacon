module CdnBacon
  module ActionViewExtensions
    def javascript_cdn_include_tag(*sources)
      js = CdnBacon.configuration[:javascripts] || {}
      tags = []

      if CdnBacon.rails_env == 'development' && CdnBacon.only_fallbacks_in_dev
        sources.each do |source|
          if js.has_key?(source) && js[source].has_key?(:fallback)
            tags << javascript_include_tag(js[source][:fallback])
          end
        end
      else
        sources.each do |source|
          if js.has_key?(source) && js[source].has_key?(:cdn)
            tags << javascript_include_tag(js[source][:cdn])

            if js[source].has_key?(:fallback) && js[source].has_key?(:fallback_test)
              tags << javascript_tag("#{js[source][:fallback_test]} || document.write(unescape('#{javascript_include_tag(js[source][:fallback]).gsub('<', '%3C')}'))")
            end
          end
        end
      end

      tags.join("\n").html_safe
    end

    def stylesheet_cdn_link_tag(*sources)
      css = CdnBacon.configuration[:stylesheets] || {}
      links = []

      if CdnBacon.rails_env == 'development' && CdnBacon.only_fallbacks_in_dev
        sources.each do |source|
          if css.has_key?(source) && css[source].has_key?(:fallback)
            links << stylesheet_link_tag(css[source][:fallback])
          end
        end
      else
        sources.each do |source|
          if css.has_key?(source) && css[source].has_key?(:cdn)
            links << stylesheet_link_tag(css[source][:cdn])
          end
        end
      end

      links.join("\n").html_safe
    end
  end
end