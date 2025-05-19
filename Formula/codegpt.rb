# Ported from https://github.com/appleboy/homebrew-tap/blob/ae2c28c76656320757ad23262590e5ec6bc46777/codegpt.rb

class Codegpt < Formula
  desc "CLI tool that writes git commit messages using ChatGPT AI"
  homepage "https://github.com/appleboy/CodeGPT"
  version "1.0.0"
  
  url "https://github.com/appleboy/CodeGPT/releases/download/v1.0.0/CodeGPT-1.0.0-darwin-arm64.xz"
  sha256 "3ab04ad37f2feb6fd96a5909b73be38cad391a63b65b4dc88e4a3c70aa50338a"
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
