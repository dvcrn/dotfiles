import subprocess
from typing import List

go_packages = [
    # Core tooling
    "golang.org/x/tools/gopls@latest",  # Official LSP server - keep this
    "github.com/go-delve/delve/cmd/dlv@latest",  # Debugger
    "mvdan.cc/gofumpt@latest",  # Stricter gofmt
    "github.com/golangci/golangci-lint/cmd/golangci-lint@latest",  # Meta linter
    # Optional tools
    "github.com/fatih/gomodifytags@latest",
    "github.com/josharian/impl@latest",
]


def install_packages(packages: List[str]) -> None:
    for package in packages:
        print(f"Installing {package}...")
        try:
            subprocess.run(["go", "install", package], check=True)
        except subprocess.CalledProcessError as e:
            print(f"Failed to install {package}: {e}")


if __name__ == "__main__":
    install_packages(go_packages)
