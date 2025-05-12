class Sakuramml < Formula
  desc "MML Compiler SAKURA Rust"
  homepage "https://github.com/kujirahand/sakuramml-rust"
  url "https://github.com/kujirahand/sakuramml-rust/archive/refs/tags/0.1.42.tar.gz"
  sha256 "3426153ccc96d9af3f32d1628a6af3b67010e3f95243aedd21d4ba353a1b1526"
  license "MIT"
  head "https://github.com/kujirahand/sakuramml-rust.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/sakuramml", "--help"
  end
end
