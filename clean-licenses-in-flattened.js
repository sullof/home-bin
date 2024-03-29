#!/usr/bin/env node

const fs = require("fs");
const path = require("path");

const [, , folder, contract] = process.argv;
const fn = path.resolve(folder, "flattened", `${contract}-flattened.sol`);
const flattened = fs.readFileSync(fn, "utf8");

flattened
  .replace(/SPDX-License-Identifier/, "LICENSE-ID")
  .replace(/SPDX-License-Identifier/g, "License")
  .replace(/LICENSE-ID/, "SPDX-License-Identifier");

fs.writeFileSync(
  fn,
  flattened
    .replace(/SPDX-License-Identifier/, "LICENSE-ID")
    .replace(/SPDX-License-Identifier/g, "License")
    .replace(/LICENSE-ID/, "SPDX-License-Identifier")
);
