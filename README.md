<p align="center">
  <a href="https://github.com/bt-rb" target="_blank" rel="noopener noreferrer">
    <img src="https://github.com/bt-rb/bridgetown-plausible/blob/main/.github/media/logo.svg" width="100px">
  </a>
</p>

<p align="center">
  <a href="https://badge.fury.io/rb/bridgetown-plausible"><img src="https://badge.fury.io/rb/bridgetown-plausible.svg" alt="Gem Version" height="18"></a>
  <img src="https://img.shields.io/github/license/bt-rb/.github">
  <img src="https://github.com/bt-rb/bridgetown-plausible/workflows/Test/badge.svg" alt="test">
  <img src="https://github.com/bt-rb/bridgetown-plausible/workflows/Lint/badge.svg" alt="lint">
  <img src="https://github.com/bt-rb/bridgetown-plausible/workflows/Release/badge.svg" alt="release">
</p>

<h2 align="center">bridgetown-plausible</h2>

[Plausible](https://plausible.io) is a lightweight and open-source website analytics tool. It doesn’t use cookies and is fully compliant with GDPR, CCPA and PECR. This plugin is meant to remove all friction from adding your [Plausible Analytics tracking script code](https://docs.plausible.io/plausible-script) to your Bridgetown site.

## Table of contents

- [Table of contents](#table-of-contents)
- [Quickstart](#quickstart)
- [System requirements](#system-requirements)
- [Installation](#installation)
- [Upgrading from 1.x](#upgrading-from-1x)
- [Configuration](#configuration)
- [Usage](#usage)
  - [Liquid](#liquid)
  - [ERB](#erb)
- [Changelog](#changelog)
- [Contribution](#contribution)
- [License](#license)

## Quickstart

Use the automation to add to your site:

```sh
bundle exec bridgetown apply https://github.com/bt-rb/bridgetown-plausible
```

## System requirements

- Bundler
- Ruby >= `3.1`
- Bridgetown >= `1.3` (tested against Bridgetown 1.3.x, 2.0.x, 2.1.x, and 2.2.x)

Bridgetown itself sets its own Ruby floor: 1.3.x needs `>= 2.7`, 2.0.x needs `>= 3.1`, 2.1.x and 2.2.x need `>= 3.2`. This gem requires `>= 3.1` to match what we test in CI; if you need Ruby 2.7 or 3.0 on Bridgetown 1.3, stay on `bridgetown-plausible "~> 1.1"`.

## Installation

Add to your `Gemfile`:

```bash
bundle add bridgetown-plausible -g bridgetown_plugins
```

or manually:

```ruby
group :bridgetown_plugins do
  gem "bridgetown-plausible", "~> 2.0"
end
```

Then configure the plugin in your `config/initializers.rb` — the recommended path is to pass your domain (and self-hosted server, if applicable) inline:

```ruby
Bridgetown.configure do |config|
  # ...your existing config...

  init :"bridgetown-plausible" do
    domain "example.com"
    # server "stats.example.com"  # optional, defaults to plausible.io
  end
end
```

Alternatively, you can configure via `bridgetown.config.yml` (see [Configuration](#configuration) below) and use the bare `init :"bridgetown-plausible"` form. Precedence is per-key: any kwarg you pass overrides the matching YAML key, and keys you don't pass continue to come from YAML. So passing only `domain` in the init block will still pick up `server` from `bridgetown.config.yml` if it's set there.

## Upgrading from 1.x

Version 2.0 is a breaking change:

- **Requires Bridgetown >= 1.3.** If you're on an older Bridgetown, stay on `bridgetown-plausible "~> 1.1"` until you can upgrade.
- **The gem no longer auto-registers on `require`.** You must explicitly opt in by adding `init :"bridgetown-plausible"` to your `config/initializers.rb` (see [Installation](#installation)). Without this, builds calling `<%= plausible %>` will raise `NameError: undefined local variable or method 'plausible'`, and `{% plausible %}` will raise `Liquid::SyntaxError`.
- **Ruby >= 3.1** (matching what we test in CI). See [System requirements](#system-requirements) for the per-Bridgetown-version Ruby floors set by Bridgetown itself.
- **Active Support was removed from Bridgetown in 2.1.** The plugin's `.html_safe` calls continue to work via `bridgetown-foundation`, which Bridgetown ships by default — no action needed.

## Configuration

You can configure via the initializer kwargs shown in [Installation](#installation), or via `bridgetown.config.yml`:

```yml
# bridgetown.config.yml

plausible:
  # Your Plausible domain.
  # Note that this domain should not include www or https://
  #
  # Type: String
  # Required: true
  domain: example.com
  # Your Plausible instance domain.
  # Only set this if you are self-hosting Plausible on your own domain.
  # Requires https.
  #
  # Type: String
  # Required: false
  # Default: "plausible.io"
  server: selfhosted-plausible.com
```

## Usage

This plugin provides the `plausible` Liquid tag & ERB helper to your site. If `BRIDGETOWN_ENV` is not `production`, then the tag will be wrapped in an HTML comment to prevent console errors in development. Make sure you set `BRIDGETOWN_ENV="production"` when you deploy in your script or in Netlify/Vercel/etc.

Use the tag in the head of your document:

### Liquid

```liquid
{% plausible %}
```

### ERB

```erb
<%= plausible %>
```

## Changelog

Detailed changes for each release are documented in the [release notes](https://github.com/bt-rb/bridgetown-plausible/releases).

## Contribution

Please make sure to read the [Contributing Guide](.github/CONTRIBUTING.md) before making a pull request.

## License

[MIT](https://opensource.org/licenses/MIT)

Copyright (c) 2021-present, Andrew Mason
