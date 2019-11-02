import os

packages = [
    # javascript
    'gulp',
    'tern',
    'n',
    # linting
    'jslint',
    'eslint',
    'eslint-plugin-react',
    'eslint-config-airbnb',

    # typescript
    'typescript'
    'gts', # typescript code formatter
    'tslint',

    # etc
    'prettier',

    # lsp
    'typescript-language-server',
    'bash-language-server',
]

os.system('npm install -g yarn')
os.system('yarn global add %s' % ' '.join(packages))
