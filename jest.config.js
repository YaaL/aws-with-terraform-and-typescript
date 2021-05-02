module.exports = {
    preset: "ts-jest",
    testEnvironment: "node",
    modulePathIgnorePatterns: [],
    modulePaths: ["<rootDir>/handlers", "<rootDir>/tests"],
    globals: {
      "ts-jest": {
        tsconfig: "tsconfig.json",
      },
    },
  }
