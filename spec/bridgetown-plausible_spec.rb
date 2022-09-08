# frozen_string_literal: true

require "spec_helper"

describe(Bridgetown::Plausible) do
  let(:overrides) { {} }
  let(:config) do
    Bridgetown.configuration(Bridgetown::Utils.deep_merge_hashes({
      "full_rebuild" => true,
      "root_dir" => root_dir,
      "source" => source_dir,
      "destination" => dest_dir
    }, overrides))
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
end
