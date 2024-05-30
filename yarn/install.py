import os

packages = [
    # javascript
    'tern',

    # linting
    'eslint',
    'eslint-plugin-react',
    'eslint-config-airbnb',

    # typescript
    'typescript',
    'gts',

    # etc
    'prettier',
    'prettier-eslint-cli',
    'prettier-plugin-solidity',

    # lsp
    'typescript-language-server',
    'bash-language-server',
    'dockerfile-language-server-nodejs',

    # CLI tools
    'spoof',
    'npm-check-updates',
]

os.system('yarn global add %s' % ' '.join(packages))
