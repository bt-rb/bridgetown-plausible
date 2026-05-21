# frozen_string_literal: true

require "spec_helper"

describe(Bridgetown::Plausible) do
  around(:each) do |example|
    original_env = ENV["BRIDGETOWN_ENV"]
    example.run
  ensure
    ENV["BRIDGETOWN_ENV"] = original_env
  end

  let(:overrides) { {} }
  let(:config) do
    Bridgetown.reset_configuration!
    Bridgetown.configuration(Bridgetown::Utils.deep_merge_hashes({
      "full_rebuild" => true,
      "root_dir" => root_dir,
      "source" => source_dir,
      "destination" => dest_dir
    }, overrides)).tap do |c|
      c.run_initializers!(context: :static)
    end
  end
  let(:site) { Bridgetown::Site.new(config) }

  context "when the environment is production" do
    before(:each) do
      ENV["BRIDGETOWN_ENV"] = "production"
      site.process
    end

    context "when the rendering engine is liquid" do
      let(:contents) { File.read(dest_dir("liquid/index.html")) }

      context "when the domain is configured" do
        let(:overrides) { {"plausible" => {"domain" => "tracked-site.com"}} }
        it "outputs the correct HTML" do
          expect(contents).to match <<~HTML
            <script async defer data-domain="tracked-site.com" src="https://plausible.io/js/plausible.js"></script>
          HTML
        end
      end

      context "when server && domain are configured" do
        let(:overrides) { {"plausible" => {"server" => "selfhosted-plausible.com", "domain" => "tracked-site.com"}} }
        it "outputs the correct HTML" do
          expect(contents).to match <<~HTML
            <script async defer data-domain="tracked-site.com" src="https://selfhosted-plausible.com/js/plausible.js"></script>
          HTML
        end
      end

      context "when the domain is not configured" do
        it "outputs the correct HTML" do
          expect(contents).to match <<~HTML
            <script async defer data-domain="NOT CONFIGURED" src="https://plausible.io/js/plausible.js"></script>
          HTML
        end
      end
    end

    context "when the rendering engine is erb" do
      let(:contents) { File.read(dest_dir("erb/index.html")) }

      context "when the domain is configured" do
        let(:overrides) { {"plausible" => {"domain" => "tracked-site.com"}} }
        it "outputs the correct HTML" do
          expect(contents).to match <<~HTML
            <script async defer data-domain="tracked-site.com" src="https://plausible.io/js/plausible.js"></script>
          HTML
        end
      end

      context "when server && domain are configured" do
        let(:overrides) { {"plausible" => {"server" => "selfhosted-plausible.com", "domain" => "tracked-site.com"}} }
        it "outputs the correct HTML" do
          expect(contents).to match <<~HTML
            <script async defer data-domain="tracked-site.com" src="https://selfhosted-plausible.com/js/plausible.js"></script>
          HTML
        end
      end

      context "when the domain is not configured" do
        it "outputs the correct HTML" do
          expect(contents).to match <<~HTML
            <script async defer data-domain="NOT CONFIGURED" src="https://plausible.io/js/plausible.js"></script>
          HTML
        end
      end
    end
  end

  context "when the environment is not production" do
    before(:each) do
      ENV["BRIDGETOWN_ENV"] = "test"
      site.process
    end

    context "when the rendering engine is liquid" do
      let(:contents) { File.read(dest_dir("liquid/index.html")) }

      context "when the domain is configured" do
        let(:overrides) { {"plausible" => {"domain" => "example.com"}} }
        it "outputs the correct HTML" do
          expect(contents).to match <<~HTML
            <!-- <script async defer data-domain="example.com" src="https://plausible.io/js/plausible.js"></script> -->
          HTML
        end
      end

      context "when server && domain are configured" do
        let(:overrides) { {"plausible" => {"server" => "selfhosted-plausible.com", "domain" => "tracked-site.com"}} }
        it "outputs the correct HTML" do
          expect(contents).to match <<~HTML
            <!-- <script async defer data-domain="tracked-site.com" src="https://selfhosted-plausible.com/js/plausible.js"></script> -->
          HTML
        end
      end

      context "when the domain is not configured" do
        it "outputs the correct HTML" do
          expect(contents).to match <<~HTML
            <!-- <script async defer data-domain="NOT CONFIGURED" src="https://plausible.io/js/plausible.js"></script> -->
          HTML
        end
      end
    end

    context "when the rendering engine is erb" do
      let(:contents) { File.read(dest_dir("erb/index.html")) }

      context "when the domain is configured" do
        let(:overrides) { {"plausible" => {"domain" => "example.com"}} }
        it "outputs the correct HTML" do
          expect(contents).to match <<~HTML
            <!-- <script async defer data-domain="example.com" src="https://plausible.io/js/plausible.js"></script> -->
          HTML
        end
      end

      context "when server && domain are configured" do
        let(:overrides) { {"plausible" => {"server" => "selfhosted-plausible.com", "domain" => "tracked-site.com"}} }
        it "outputs the correct HTML" do
          expect(contents).to match <<~HTML
            <!-- <script async defer data-domain="tracked-site.com" src="https://selfhosted-plausible.com/js/plausible.js"></script> -->
          HTML
        end
      end

      context "when the domain is not configured" do
        it "outputs the correct HTML" do
          expect(contents).to match <<~HTML
            <!-- <script async defer data-domain="NOT CONFIGURED" src="https://plausible.io/js/plausible.js"></script> -->
          HTML
        end
      end
    end
  end

  describe "initializer kwargs" do
    # Invoke the registered :"bridgetown-plausible" initializer block as Bridgetown itself would —
    # via the ConfigurationDSL so `config.builder` resolves correctly.
    def call_initializer(config, **kwargs)
      block = Bridgetown::Current.preloaded_configuration.initializers[:"bridgetown-plausible"].block
      dsl = config.initializers_dsl(context: :static)
      dsl.instance_exec(dsl, **kwargs, &block)
    end

    def fresh_config(overrides = {})
      Bridgetown.reset_configuration!
      Bridgetown.configuration({"root_dir" => root_dir}.merge(overrides))
    end

    it "writes domain and server kwargs into config.plausible" do
      config = fresh_config
      call_initializer(config, domain: "kwargs.example.com", server: "stats.example.com")

      expect(config["plausible"]["domain"]).to eq("kwargs.example.com")
      expect(config["plausible"]["server"]).to eq("stats.example.com")
    end

    it "preserves YAML-sourced config when no kwargs are passed" do
      config = fresh_config("plausible" => {"domain" => "yaml.example.com"})
      call_initializer(config)

      expect(config["plausible"]["domain"]).to eq("yaml.example.com")
    end

    it "lets kwargs override YAML when both are present" do
      config = fresh_config("plausible" => {"domain" => "yaml.example.com"})
      call_initializer(config, domain: "kwargs.example.com")

      expect(config["plausible"]["domain"]).to eq("kwargs.example.com")
    end
  end
end
