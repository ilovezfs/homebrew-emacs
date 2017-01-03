require File.expand_path("../../Homebrew/emacs_formula", __FILE__)

class Helm < EmacsFormula
  desc "Emacs completion and selection narrowing framework"
  homepage "https://emacs-helm.github.io/helm/"
  url "https://github.com/emacs-helm/helm/archive/v2.3.4.tar.gz"
  sha256 "421ba26953566e2777f8dd7c07b3ee9ba7465bcd235a16b2961e099d1e68c69e"
  head "https://github.com/emacs-helm/helm.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "7c66248043b0682a518aa76d803b549e1043f5821f0ded295ecc0348b9404ad1" => :sierra
    sha256 "a979bdca85e5018e3644e9ef2a9265be824ee45a0c402bb001d4f6cfe55d5f9b" => :el_capitan
    sha256 "a979bdca85e5018e3644e9ef2a9265be824ee45a0c402bb001d4f6cfe55d5f9b" => :yosemite
  end

  depends_on :emacs => "24.3"
  depends_on "homebrew/emacs/async-emacs"

  def install
    system "make"
    elisp.install Dir["*.el"], Dir["*.elc"]
  end

  test do
    (testpath/"test.el").write <<-EOS.undent
      (add-to-list 'load-path "#{share}/emacs/site-lisp/helm")
      (load "helm-config")
      (print (minibuffer-prompt-width))
    EOS
    assert_equal "0", shell_output("emacs -Q --batch -l #{testpath}/test.el").strip
  end
end
