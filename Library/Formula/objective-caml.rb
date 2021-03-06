class ObjectiveCaml < Formula
  homepage "http://ocaml.org"
  url "http://caml.inria.fr/pub/distrib/ocaml-4.02/ocaml-4.02.1.tar.gz"
  sha1 "6af8c67f2badece81d8e1d1ce70568a16e42313e"
  revision 2

  head "http://caml.inria.fr/svn/ocaml/trunk", :using => :svn

  option "with-x11", "Install with the Graphics module"

  depends_on :ld64
  depends_on :x11 => :optional

  bottle do
    revision 1
    sha1 "ff2aad908892c78304c153c4c744954f1dadc5c7" => :yosemite
    sha1 "624ddd8c46b91daa51658e06d4ac1e3e20012779" => :mavericks
    sha1 "fa162f9f75ea191f0f9dd59298a0b62c2c761118" => :mountain_lion
  end

  # Removes -no_compact_unwind, which wasn't available in Leopard's ld
  patch :p1 do
    url "https://gist.githubusercontent.com/anonymous/1f3cf8cd60be707ab3b9/raw/2d46e20089892c2a87c04627733c6b7bbb1004fc/-"
    sha1 "1576b98b1b175e4299193e357cddd81422545b6f"
  end if MacOS.version < :snow_leopard

  def install
    args = %W[
      --prefix #{HOMEBREW_PREFIX}
      --mandir #{man}
      -with-debug-runtime
    ]
    args << "-cc" << "#{ENV.cc} #{ENV.cflags}"
    args << "-aspp" << "#{ENV.cc} #{ENV.cflags} -c"
    args << "-no-graph" if build.without? "x11"

    ENV.deparallelize # Builds are not parallel-safe, esp. with many cores
    system "./configure", *args
    system "make", "world"
    system "make", "opt"
    system "make", "opt.opt"
    system "make", "PREFIX=#{prefix}", "install"
  end
end
