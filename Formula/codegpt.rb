# Ported from https://github.com/appleboy/homebrew-tap/blob/ae2c28c76656320757ad23262590e5ec6bc46777/codegpt.rb

class Codegpt < Formula
  desc "CLI tool that writes git commit messages using ChatGPT AI"
  homepage "https://github.com/appleboy/CodeGPT"
  url "https://github.com/appleboy/CodeGPT/releases/download/v1.1.0/CodeGPT-1.1.0-darwin-arm64.xz"
  version "1.1.0"

  sha256 "7d29ed1b7a8cfa2ac9377a7a8cf8a2856bebbedc014c095c09894a09aae0cdce"
  depends_on "git"
  depends_on "xz"
  depends_on "zsh" => :optional

  def install
    filename = "CodeGPT-#{version}-darwin-arm64"
    bin.install filename => "codegpt"
  end

  test do
    system "#{bin}/codegpt", "version"
  end
end
