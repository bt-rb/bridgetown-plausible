<p align="center">
  <a href="https://github.com/bt-rb" target="_blank" rel="noopener noreferrer">
    <img src=".github/media/logo.svg" width="100px">
  </a>
</p>

<p align="center">
  <img src="https://img.shields.io/github/license/bt-rb/.github">
</p>

<h2 align="center">bridgetown-plausible</h2>

[Plausible](https://plausible.io) is a lightweight and open-source website analytics tool. It doesn’t use cookies and is fully compliant with GDPR, CCPA and PECR. This plugin is meant to remove all friction from adding your [Plausible Analytics tracking script code](https://docs.plausible.io/plausible-script) to your Bridgetown site.

## Table of contents

- [Table of contents](#table-of-contents)
- [Quickstart](#quickstart)
- [System requirements](#system-requirements)
- [Installation](#installation)
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
bundle exec bridgetown apply https://github.com/btrb/bridgetown-plausible
```

## System requirements

- Ruby >= `2.5`
- Bundler
- Bridgetown >= `0.16`

## Installation

Automatically add to `Gemfile`:

```bash
bundle add bridgetown-plausible -g bridgetown_plugins
```

or add manually in `Gemfile`:

```ruby
group :bridgetown_plugins do
  gem "bridgetown-plausible", "~> 0.1.0"
end
```

Run `bundle install` and then modify your `bridgetown.config.yml` configuration to point to your Plausible domain.

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
```

## Usage

This plugin provides the `plausible` Liquid tag & ERB helper to your site. If `BRIDGETOWN_ENV` is not `production`, than the tag will be wrapped in an HTML comment to prevent console erros in development. Make sure you set `BRIDGETOWN_ENV="production"` when you deploy in your script or in Netlify/Vercel/etc.

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
