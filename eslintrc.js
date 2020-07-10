module.exports = {
  "extends": "eslint:recommended",
  "plugins": [
    "promise",
  ],
  "parserOptions": {
    "ecmaFeatures": {
      "jsx": true
    }
  },
  "rules": {
    "semi": ["off"],
    "space-before-function-paren": ["error", "never"],
  }
};
