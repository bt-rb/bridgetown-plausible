say_status :plausible, "Installing the bridgetown-plausible plugin..."

domain_name = ask("What's your Plausible domain?")
server_name = ask("If you are self-hosting Plausible, what's your instance domain? Leave blank if not self-hosting to default to plausible.io")
add_bridgetown_plugin "bridgetown-plausible"

if server_name == ""
  append_to_file "bridgetown.config.yml" do
    <<~YAML

      plausible:
        domain: #{domain_name}
    YAML
  end
else
  append_to_file "bridgetown.config.yml" do
    <<~YAML

      plausible:
        domain: #{domain_name}
        server: #{server_name}
    YAML
  end
end

say_status :plausible, "All set! Double-check the plausible block in your config file and review docs at"
say_status :plausible, "https://github.com/bt-rb/bridgetown-plausible"
