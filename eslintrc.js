module.exports = {
  "extends": "standard",
  "plugins": [
    "standard",
    "promise",
    "react"
  ],
  "parserOptions": {
    "ecmaFeatures": {
      "jsx": true
    }
  },
  "rules": {
    "semi": ["off"],
    "space-before-function-paren": ["error", "never"],
    "react/jsx-uses-vars": "error"
  }
};
