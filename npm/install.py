import os

packages = [
    # react native
    'react-native-cli',
    'react-native',

    # clojurescript
    're-natal',

    # javascript
    'gulp',
    'tern',
    'n',

    # lsp
    'typescript-language-server',
    'bash-language-server',

    # linting
    'jslint',
    'eslint',
    'eslint-plugin-react',
    'eslint-config-airbnb',
]

os.system('npm install -g yarn')
os.system('yarn global add %s' % ' '.join(packages))
