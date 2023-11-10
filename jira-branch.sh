#!/usr/bin/env node

const { execSync } = require('child_process');

const [,, tickedNumber, title] = process.argv;

const newBranch = `CD-${tickedNumber}-${title.replace(/ /g, '-')}`;
execSync(`git checkout -b ${newBranch}`);
