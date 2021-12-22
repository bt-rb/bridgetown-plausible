say_status :plausible, "Installing the bridgetown-plausible plugin..."

domain_name = ask("What's your Plausible domain?")

add_bridgetown_plugin "bridgetown-plausible"

append_to_file "bridgetown.config.yml" do
  <<~YAML

    plausible:
      domain: #{domain_name}
  YAML
end

say_status :plausible, "All set! Double-check the plausible block in your config file and review docs at"
say_status :plausible, "https://github.com/bt-rb/bridgetown-plausible"
