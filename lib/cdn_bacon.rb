require "cdn_bacon/version"
require "cdn_bacon/action_view_extensions"
require "cdn_bacon/railtie" if defined? Rails

module CdnBacon
  APP_ROOT = File.expand_path((defined?(Rails) && !Rails.root.blank?) ? Rails.root : ENV['RAILS_ROOT'] || ".")
  DEFAULT_CONFIG_PATH = File.join(APP_ROOT, 'config', 'cdn_assets.yml')

  class MissingConfiguration < NameError; end

  class << self
    attr_reader :configuration, :only_fallbacks_in_dev, :rails_env
  end

  @configuration = {}

  # Load the configuration from the specified @config_path@
  def self.load_configuration(config_path)
    exists = config_path && File.exists?(config_path)
    raise MissingConfiguration, "could not find the \"#{config_path}\" configuration file" unless exists

    conf = YAML.load(ERB.new(File.read(config_path)).result)
    @rails_env = (defined?(Rails) ? ::Rails.env : ENV['RAILS_ENV'] || "development")

    @configuration = symbolize_keys(conf)
    @only_fallbacks_in_dev = conf[:only_fallbacks_in_dev] || false
    symbolize_keys(conf[:javascripts]) if conf[:javascripts]
    symbolize_keys(conf[:stylesheets]) if conf[:stylehseets]
    self
  end

  private

  # Clone of active_support's symbolize_keys. 
  # Converts a hash's keys to all symbols.
  def self.symbolize_keys(hash)
    hash.keys.each do |key|
      val = hash.delete(key)
      hash[(key.to_sym rescue key)] = val.is_a?(Hash) ? symbolize_keys(val) : val
    end
    hash
  end
end

CdnBacon.load_configuration(CdnBacon::DEFAULT_CONFIG_PATH) if defined? Rails