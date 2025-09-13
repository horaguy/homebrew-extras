class Sakuramml < Formula
  desc "MML Compiler SAKURA Rust"
  homepage "https://github.com/kujirahand/sakuramml-rust"
  url "https://github.com/kujirahand/sakuramml-rust/archive/refs/tags/0.1.43.tar.gz"
  sha256 "a7e0de96fb42f734d86fa82a9e89ca1b17f2a315b7a4aa3ee53de2af6c75e128"
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
