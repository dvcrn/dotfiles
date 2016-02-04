import os

packages = [
    # react native
    'react-native-cli',
    'react-native',

    # clojurescript
    'natal',
    're-natal',

    # javascript
    'mocha',
    'gulp',
    'tern',

    ## linting
    'eslint',
    'eslint-plugin-react',
    'eslint-config-airbnb'
]

os.system('npm install -g %s' % ' '.join(packages))
