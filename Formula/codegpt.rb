# Ported from https://github.com/appleboy/homebrew-tap/blob/ae2c28c76656320757ad23262590e5ec6bc46777/codegpt.rb

class Codegpt < Formula
  desc "CLI tool that writes git commit messages using ChatGPT AI"
  homepage "https://github.com/appleboy/CodeGPT"
  url "https://github.com/appleboy/CodeGPT/releases/download/v1.2.1/CodeGPT-1.2.1-darwin-arm64.xz"
  version "1.2.1"
  sha256 "3d7fcf87fe63adcf7ae745468634ff9fbc49d42d5767c92b2c181c53691cf4f1"

  def install
    filename = "CodeGPT-#{version}-darwin-arm64"
    bin.install filename => "codegpt"
  end

  test do
    system "#{bin}/codegpt", "version"
  end
end
