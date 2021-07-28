#!/usr/bin/env node

const fs = require('fs')
const path = require('path')

function renameScratchFolders(p) {
	const dir = fs.readdirSync(p)
	for (let f of dir) {
		if (!f) continue
		let fp = path.join(p, f)
		if (fs.lstatSync(fp).isDirectory()) {
			renameScratchFolders(fp)
		}
		if (f === '.scratch') {
			fs.renameSync(fp, path.join(p, '_sullof'))
		}
	}
}

renameScratchFolders(process.argv[2])

