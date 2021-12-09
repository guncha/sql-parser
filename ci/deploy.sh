#!/usr/bin/env bash
set -e
npm run build
npx semantic-release
