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

- Ruby >= `3.0`
- Bundler
- Bridgetown >= `1.3` (tested against Bridgetown 1.3.x and 2.x)

## Installation

Automatically add to `Gemfile`:

```bash
bundle add bridgetown-plausible -g bridgetown_plugins
```

or add manually in `Gemfile`:

```ruby
group :bridgetown_plugins do
  gem "bridgetown-plausible", "~> 2.0"
end
```

Then add the initializer inside the existing `Bridgetown.configure` block in `config/initializers.rb`:

```ruby
Bridgetown.configure do |config|
  # ...your existing config...

  init :"bridgetown-plausible"
end
```

Run `bundle install` and then modify your `bridgetown.config.yml` configuration to point to your Plausible domain.

## Upgrading from 1.x

Version 2.0 is a breaking change:

- **Requires Bridgetown >= 1.3.** If you're on an older Bridgetown, stay on `bridgetown-plausible "~> 1.1"` until you can upgrade.
- **The gem no longer auto-registers on `require`.** You must explicitly opt in by adding `init :"bridgetown-plausible"` to your `config/initializers.rb` (see [Installation](#installation)). Without this, builds calling `<%= plausible %>` will raise `NameError: undefined local variable or method 'plausible'`, and `{% plausible %}` will raise `Liquid::SyntaxError`.
- **Requires Ruby >= 3.0.**

## Configuration

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
