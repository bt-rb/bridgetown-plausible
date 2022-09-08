# frozen_string_literal: true

module Bridgetown
  module Plausible
    class Builder < Bridgetown::Builder
      def build
        liquid_tag "plausible" do |_attributes, tag|
          render.html_safe
        end

        helper "plausible" do
          render.html_safe
        end
      end

      private

      def render
        domain = options.dig(:domain)&.strip
        server = options.dig(:server)&.strip || "plausible.io"

        tag = if domain && server
          markup_for_snippet(domain, server)
        else
          Bridgetown.logger.warn "Plausible", "Domain and/or server not configured."
          markup_for_snippet("NOT CONFIGURED", server)
        end

        return wrap_with_comment(tag) unless Bridgetown.environment.production?

        tag
      end

      def markup_for_snippet(domain, server)
        "<script async defer data-domain=\"#{domain}\" src=\"https://#{server}/js/plausible.js\"></script>"
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
