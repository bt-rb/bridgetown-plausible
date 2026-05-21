say_status :plausible, "Installing the bridgetown-plausible plugin..."

domain_name = ask("What's your Plausible domain?")
server_name = ask("If you are self-hosting Plausible, what's your instance domain? Leave blank if not self-hosting to default to plausible.io")
add_bridgetown_plugin "bridgetown-plausible"

init_block = if server_name.to_s.strip.empty?
  <<~RUBY

    init :"bridgetown-plausible" do
      domain #{domain_name.inspect}
    end
  RUBY
else
  <<~RUBY

    init :"bridgetown-plausible" do
      domain #{domain_name.inspect}
      server #{server_name.inspect}
    end
  RUBY
end

if File.exist?("config/initializers.rb")
  if File.read("config/initializers.rb").include?(%(init :"bridgetown-plausible"))
    say_status :plausible, "config/initializers.rb already calls `init :\"bridgetown-plausible\"` — skipping."
  else
    # Indent the init block to match the surrounding Bridgetown.configure block
    indented = init_block.lines.map { |l| (l == "\n") ? l : "  #{l}" }.join
    inject_into_file "config/initializers.rb", indented, before: /^end\s*\z/
  end
else
  say_status :plausible, "config/initializers.rb not found. bridgetown-plausible 2.x requires Bridgetown >= 1.3."
  say_status :plausible, "Upgrade Bridgetown to 1.3+ (and configure via config/initializers.rb), or use bridgetown-plausible `~> 1.1` for older Bridgetown sites."
end

say_status :plausible, "All set! Review docs at https://github.com/bt-rb/bridgetown-plausible"
