#!/bin/bash

bun oxlint --fix --jsdoc-plugin --jest-plugin --vitest-plugin --jsx-a11y-plugin --nextjs-plugin --react-perf-plugin && next lint && eslint . --fix