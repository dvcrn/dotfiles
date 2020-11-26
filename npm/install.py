import os

packages = [
    # javascript
    'tern',
    'n',

    # linting
    'eslint',
    'eslint-plugin-react',
    'eslint-config-airbnb',

    # typescript
    'typescript',
    'gts',

    # etc
    'prettier',

    # lsp
    'typescript-language-server',
    'bash-language-server',
    'dockerfile-language-server-nodejs',
]

os.system('npm install -g yarn')
os.system('yarn add global %s' % ' '.join(packages))
