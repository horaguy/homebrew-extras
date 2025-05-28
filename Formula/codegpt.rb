# Ported from https://github.com/appleboy/homebrew-tap/blob/ae2c28c76656320757ad23262590e5ec6bc46777/codegpt.rb

class Codegpt < Formula
  desc "CLI tool that writes git commit messages using ChatGPT AI"
  homepage "https://github.com/appleboy/CodeGPT"
  url "https://github.com/appleboy/CodeGPT/releases/download/v1.1.1/CodeGPT-1.1.1-darwin-arm64.xz"
  version "1.1.1"
  sha256 "d2c34522ce1ca058be98c16b8c346f0feb31c25ba0d232c1acbd1eae0e283829"

  def install
    filename = "CodeGPT-#{version}-darwin-arm64"
    bin.install filename => "codegpt"
  end

  test do
    system "#{bin}/codegpt", "version"
  end
end
