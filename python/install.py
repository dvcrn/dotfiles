import subprocess

packages = [
    "python-lsp-server[all]",
    "flake8",
    "pycodestyle",
    "black",
    "ruff",
    "virtualenv",
    "git+https://github.com/dvcrn/wework-cli.git",
    "git+https://github.com/dvcrn/chainenv.git",
    "git+https://github.com/dvcrn/anthropic-cli",
]

for tool in packages:
    subprocess.run(["pipx", "install", tool], check=True)
