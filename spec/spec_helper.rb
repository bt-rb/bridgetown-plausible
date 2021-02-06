# frozen_string_literal: true

require "bridgetown"
require File.expand_path("../lib/bridgetown-plausible", __dir__)

Bridgetown.logger.log_level = :error
ROOT_DIR = File.expand_path("fixtures", __dir__)
SOURCE_DIR = File.join(ROOT_DIR, "src")
DEST_DIR = File.expand_path("dest", __dir__)

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = "random"

  def root_dir(*files)
    File.join(ROOT_DIR, *files)
  end

  def source_dir(*files)
    File.join(SOURCE_DIR, *files)
  end

  def dest_dir(*files)
    File.join(DEST_DIR, *files)
  end

  def make_context(registers = {})
    Liquid::Context.new({}, {}, {site: site}.merge(registers))
  end
end
