# typed: false
# frozen_string_literal: true

class BorneoCli < Formula
  desc "Command Line Interface (CLI) for the Borneo API"
  homepage "https://www.borneo.io/"
  version "3.9.1"
  version_scheme 1

  URL_ARM="https://github.com/borneodata/homebrew-tap/releases/download/v3.9.1/borneo-v3.9.1-b23678aa3-darwin-arm64.tar.gz"
  SHA_ARM="8412428126bd3a685d6980dcc79d0c09dd58c9199074c2ae750a3bc1077a8fd1"
  URL_X64="https://github.com/borneodata/homebrew-tap/releases/download/v3.9.1/borneo-v3.9.1-b23678aa3-darwin-x64.tar.gz"
  SHA_X64="c510a65c9330bf9c9dad4b296ab4186cb0891266676b642056cbeda1755e10f8"

  url URL_ARM
  sha256 SHA_ARM

  on_macos do
    if Hardware::CPU.intel?
      url URL_X64
      sha256 SHA_X64
    end
  end

  def install
    inreplace "bin/borneo", /^CLIENT_HOME=/, "export BORNEO_OCLIF_CLIENT_HOME=#{lib/"client"}\nCLIENT_HOME="
    libexec.install Dir["*"]
    bin.install_symlink libexec/"bin/borneo"
  end

  test do
    system bin/"borneo", "version"
  end
end
