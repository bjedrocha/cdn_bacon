# CdnBacon

Provides two view helpers for loading Javascript and CSS libraries from a CDN into your Rails application.

## Installation

Add this line to your application's Gemfile:

    gem 'cdn_bacon'

And then execute:

    $ bundle

## Usage

Define a configuration file under `config/cdn_assets.yml`

````yaml
# set to true if you only want local(fallback) versions loaded in dev
only_fallbacks_in_dev: false

javascripts:
  jquery:
    cdn: "//cdnjs.cloudflare.com/ajax/libs/jquery/2.0.0/jquery.min.js"
    fallback: "jquery-2.0.0"
    fallback_test: "window.jQuery"

  jquery_ui:
    cdn: "//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"
    fallback: "jquery-ui-1.10.3"
    fallback_test: "window.jQuery.ui"

  modernizr:
    cdn: "//cdnjs.cloudflare.com/ajax/libs/modernizr/2.6.2/modernizr.min.js"
    fallback: "modernizr-2.6.2"
    fallback_test: "window.Modernizr"

  underscore:
    cdn: "//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.4.4/underscore-min.js"
    fallback: "underscore-1.4.4"
    fallback_test: "window._"

stylesheets:
  jquery_ui:
    cdn: "//cdnjs.cloudflare.com/ajax/libs/jqueryui/1.10.3/css/base/jquery-ui.css"
    fallback: "jquery-ui-1.10.3"

  font_awesome:
    cdn: "//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css"
    fallback: "font-awesome-4.0.3"
````

You can then do the following in your layouts

````erb
<%= javascript_cdn_include_tag :jquery, :underscore %>
<%= stylesheet_cdn_link_tag :font_awesome %>
````

which will generate the following

````html
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/2.0.0/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript">
//<![CDATA[
window.jQuery || document.write(unescape('%3Cscript src="/javascripts/libraries/jquery-2.0.0.js?1371735212" type="text/javascript">%3C/script>'))
//]]>
</script>
<script src="//cdnjs.cloudflare.com/ajax/libs/underscore.js/1.4.4/underscore-min.js" type="text/javascript"></script>
<script type="text/javascript">
//<![CDATA[
window._ || document.write(unescape('%3Cscript src="/javascripts/libraries/underscore-1.4.4.js?1371735212" type="text/javascript">%3C/script>'))
//]]>
</script>
<link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" media="screen" rel="stylesheet" type="text/css">
````

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License
Copyright (c) 2013 Bart Jedrocha, released under the MIT License.