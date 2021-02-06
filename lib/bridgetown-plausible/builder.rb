# frozen_string_literal: true

module Bridgetown
  module Plausible
    class Builder < Bridgetown::Builder
      def build
        liquid_tag "plausible" do |_attributes, tag|
          render
        end

        helper "plausible" do
          render
        end
      end

      private

      def render
        domain = options.dig(:domain)&.strip

        tag = if domain
          markup_for_domain(domain)
        else
          Bridgetown.logger.warn "Plausible", "Domain not configured."
          markup_for_domain("NOT CONFIGURED")
        end

        return wrap_with_comment(tag) unless Bridgetown.environment.production?

        tag
      end

      def markup_for_domain(domain)
        "<script async defer data-domain=\"#{domain}\" src=\"https://plausible.io/js/plausible.js\"></script>"
      end

      def wrap_with_comment(tag)
        "<!-- #{tag} -->"
      end

      def options
        config["plausible"] || {}
      end
    end
  end
end

Bridgetown::Plausible::Builder.register
