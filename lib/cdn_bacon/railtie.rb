module CdnBacon
  class Railtie < Rails::Railtie
    initializer 'cdn_bacon.action_view' do
      ActiveSupport.on_load(:action_view) do
        include CdnBacon::ActionViewExtensions
      end
    end
  end
end