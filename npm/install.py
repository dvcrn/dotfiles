import os

packages = [
    # react native
    'react-native-cli',
    'react-native',

    # clojurescript
    're-natal',

    # javascript
    'mocha',
    'gulp',
    'tern',
    'yarn',
    'n',

    # linting
    'jslint',
    'eslint',
    'eslint-plugin-react',
    'eslint-config-airbnb',

    # dev tools
    'jpm',

    # my stuff
    'gpr',
    'lab-cli'
]

os.system('npm install -g %s' % ' '.join(packages))
