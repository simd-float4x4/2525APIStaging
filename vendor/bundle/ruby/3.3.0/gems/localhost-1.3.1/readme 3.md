# Localhost

This gem provides a convenient API for generating per-user self-signed root certificates.

[![Development Status](https://github.com/socketry/localhost/workflows/Test/badge.svg)](https://github.com/socketry/localhost/actions?workflow=Test)

## Motivation

HTTP/2 requires SSL in web browsers. If you want to use HTTP/2 for development (and you should), you need to start using URLs like `https://localhost:8080`. In most cases, this requires adding a self-signed certificate to your certificate store (e.g. Keychain on macOS), and storing the private key for the web-server to use.

I wanted to provide a server-agnostic way of doing this, primarily because I think it makes sense to minimise the amount of junky self-signed keys you add to your certificate store for `localhost`.

## Usage

Please see the [project documentation](https://socketry.github.io/localhost/) for more details.

  - [Getting Started](https://socketry.github.io/localhost/guides/getting-started/index) - This guide explains how to use `localhost` for provisioning local TLS certificates for development.

  - [Browser Configuration](https://socketry.github.io/localhost/guides/browser-configuration/index) - This guide explains how to configure your local browser in order to avoid warnings about insecure self-signed certificates.

  - [Example Server](https://socketry.github.io/localhost/guides/example-server/index) - This guide demonstrates how to use <code class="language-ruby">Localhost::Authority</code> to implement a simple HTTPS client & server.

## Contributing

We welcome contributions to this project.

1.  Fork it.
2.  Create your feature branch (`git checkout -b my-new-feature`).
3.  Commit your changes (`git commit -am 'Add some feature'`).
4.  Push to the branch (`git push origin my-new-feature`).
5.  Create new Pull Request.

### Developer Certificate of Origin

This project uses the [Developer Certificate of Origin](https://developercertificate.org/). All contributors to this project must agree to this document to have their contributions accepted.

### Contributor Covenant

This project is governed by the [Contributor Covenant](https://www.contributor-covenant.org/). All contributors and participants agree to abide by its terms.

## See Also

  - [Falcon](https://github.com/socketry/falcon) — Uses `Localhost::Authority` to provide HTTP/2 with minimal configuration.
  - [Puma](https://github.com/puma/puma) — Supports `Localhost::Authority` to provide self-signed HTTP for local development.
