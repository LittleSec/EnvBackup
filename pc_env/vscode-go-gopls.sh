# go version > 1.13(because gopls->xurls)

gopls_deps = (
    golang.org/x/tools,
    golang.org/x/mod,
    golang.org/x/sync,
    golang.org/x/sys,
    golang.org/x/xerrors,
    github.com/sergi/go-diff,
    honnef.co/go/tools,
    mvdan.cc/gofumpt,
    mvdan.cc/xurls
)

git clone https://github.com/golang/tools.git golang.org/x/tools --depth=1
git clone https://github.com/golang/mod.git golang.org/x/mod --depth=1

git clone https://github.com/sergi/go-diff.git github.com/sergi/go-diff --depth=1
go install github.com/sergi/go-diff/diffmatchpatch

git clone https://github.com/golang/sync.git golang.org/x/sync --depth=1
go install golang.org/x/sync/errgroup

git clone https://github.com/dominikh/go-tools.git honnef.co/go/tools --depth=1
go install honnef.co/go/tools/simple
git clone https://github.com/BurntSushi/toml.git github.com/BurntSushi/toml --depth=1
go install github.com/BurntSushi/toml
go install golang.org/x/tools/go/analysis
go install honnef.co/go/tools/stylecheck
go install honnef.co/go/tools/staticcheck # dependency: (1)github.com/BurntSushi/toml

git clone https://github.com/mvdan/gofumpt.git mvdan.cc/gofumpt --depth=1
git clone https://github.com/google/go-cmp.git github.com/google/go-cmp --depth=1
go install github.com/google/go-cmp/cmp
go install mvdan.cc/gofumpt/format # dependency: (1)github.com/google/go-cmp/cmp

git clone https://github.com/golang/xerrors.git golang.org/x/xerrors --depth=1
git clone https://github.com/mvdan/xurls.git mvdan.cc/xurls --depth=1
# git clone https://github.com/mvdan/xurls.git mvdan.cc/xurls/v2 --depth=1
go install golang.org/x/xerrors
go install mvdan.cc/xurls # dependency: (1)golang.org/x/xerrors
# go install mvdan.cc/xurls/v2

git clone https://github.com/golang/sys.git golang.org/x/sys --depth=1
go install golang.org/x/sys/execabs
go install golang.org/x/tools/gopls
