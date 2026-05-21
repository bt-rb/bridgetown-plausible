# frozen_string_literal: true

require "bridgetown"
require "bridgetown-plausible/builder"
require "bridgetown-plausible/version"

Bridgetown.initializer :"bridgetown-plausible" do |config, domain: nil, server: nil|
  if domain || server
    site_config = Bridgetown::Current.preloaded_configuration
    site_config["plausible"] ||= {}
    site_config["plausible"]["domain"] = domain if domain
    site_config["plausible"]["server"] = server if server
  end
  config.builder Bridgetown::Plausible::Builder
end
