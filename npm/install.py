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

os.system('npm i -g %s' % ' '.join(packages))
