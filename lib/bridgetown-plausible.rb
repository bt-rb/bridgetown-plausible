# frozen_string_literal: true

require "bridgetown"
require "bridgetown-plausible/builder"
require "bridgetown-plausible/version"

Bridgetown.initializer :"bridgetown-plausible" do |config, domain: nil, server: nil|
  # `config.set` deep-merges the new hash into any existing one (e.g. from bridgetown.config.yml),
  # so per-key precedence works as expected: kwargs override matching YAML keys, and any keys not
  # passed as kwargs survive from YAML.
  overrides = {"domain" => domain, "server" => server}.compact
  config.set "plausible", overrides if overrides.any?

  config.builder Bridgetown::Plausible::Builder
end
