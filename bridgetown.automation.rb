say_status :plausible, "Installing the bridgetown-plausible plugin..."

domain_name = ask("What's your Plausible domain?")
server_name = ask("If you are self-hosting Plausible, what's your instance domain? Leave blank if not self-hosting to default to plausible.io")
add_bridgetown_plugin "bridgetown-plausible"

if File.exist?("config/initializers.rb")
  if File.read("config/initializers.rb").include?(%(init :"bridgetown-plausible"))
    say_status :plausible, "config/initializers.rb already calls `init :\"bridgetown-plausible\"` — skipping."
  else
    inject_into_file "config/initializers.rb", before: /^end\s*\z/ do
      %(\n  init :"bridgetown-plausible"\n)
    end
  end
else
  say_status :plausible, "config/initializers.rb not found. bridgetown-plausible 2.x requires Bridgetown >= 1.3."
  say_status :plausible, "Upgrade Bridgetown to 1.3+ (and add `init :\"bridgetown-plausible\"` to config/initializers.rb), or use bridgetown-plausible `~> 1.1` for older Bridgetown sites."
end

plausible_yaml = if server_name == ""
  <<~YAML

    plausible:
      domain: #{domain_name}
  YAML
else
  <<~YAML

    plausible:
      domain: #{domain_name}
      server: #{server_name}
  YAML
end

if File.exist?("bridgetown.config.yml")
  if File.read("bridgetown.config.yml").match?(/^plausible:/m)
    say_status :plausible, "bridgetown.config.yml already has a `plausible:` block — skipping."
  else
    append_to_file "bridgetown.config.yml", plausible_yaml
  end
else
  create_file "bridgetown.config.yml", plausible_yaml.lstrip
end

say_status :plausible, "All set! Double-check the plausible block in your config file and review docs at"
say_status :plausible, "https://github.com/bt-rb/bridgetown-plausible"
