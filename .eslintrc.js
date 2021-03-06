module.exports = {
  'extends': 'airbnb',
  'parser': 'babel-eslint',
  'env': {
    'jest': true,
  },
  'rules': {
    'no-use-before-define': 'off',
    'react/jsx-filename-extension': 'off',
    'react/prop-types': 'off',
    'react/sort-comp': 'off',
    'comma-dangle': 'off',
    'class-methods-use-this': 'off'
  },
  'globals': {
    "fetch": false
  }
}