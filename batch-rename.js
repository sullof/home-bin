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

rename(dir, find, sub)

