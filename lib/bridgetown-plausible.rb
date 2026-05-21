# frozen_string_literal: true

require "bridgetown"
require "bridgetown-plausible/builder"
require "bridgetown-plausible/version"

Bridgetown.initializer :"bridgetown-plausible" do |config|
  config.builder Bridgetown::Plausible::Builder
end
