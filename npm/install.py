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
    'yarn',
    'n',

    # linting
    'jslint',
    'eslint',
    'eslint-plugin-react',
    'eslint-config-airbnb',
]

os.system('npm install -g %s' % ' '.join(packages))
