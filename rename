#!/usr/bin/env node

const fs = require('fs-extra')
const path = require('path')

function rename(dir, find, sub) {
	const allfiles = fs.readdirSync(dir)
	for (let f of allfiles) {
		if (!f) continue
		if (RegExp(find).test(f)) {
			fs.renameSync(path.resolve(dir, f), path.resolve(dir, f.replace(RegExp(find), sub)))
		}
	}
}

[,,dir,find,sub] = process.argv;

if (!dir || !find || !sub) {
	console.log(`ERROR: Parameters missed

Usage:
  rename folder pattern replacingPattern

Examples:

  rename somedir/images _Icon_ _
  rename . someName Name

	`)
} else {
	rename(dir, find, sub)
}
