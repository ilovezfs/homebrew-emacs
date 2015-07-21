class Olivetti < Formula
  desc "Emacs minor mode for distraction-free writing"
  homepage "https://github.com/rnkn/olivetti"
  url "https://github.com/rnkn/olivetti/archive/v1.2.0.tar.gz"
  sha256 "e94a65f43e22f42be477a1fae028d4192837195b4f2e496a4c62925d47dc4d7d"

  head "https://github.com/rnkn/olivetti.git"

  def install
    (share/"emacs/site-lisp/olivetti").install "olivetti.el"
    doc.install "README.md"
  end

  test do
    (testpath/"test.el").write <<-EOS.undent
      (add-to-list 'load-path "#{HOMEBREW_PREFIX}/share/emacs/site-lisp")
      (load "olivetti")
      (olivetti-mode 1)
      (print (minibuffer-prompt-width))
    EOS
    assert_equal "0", shell_output("emacs -batch -l #{testpath}/test.el").strip
  end
end
