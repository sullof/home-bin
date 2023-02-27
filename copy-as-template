#!/usr/bin/env node
const path = require('path')
const fs = require('fs-extra')
let [, , src, dest, reset] = process.argv

async function main() {

	src = path.resolve(process.cwd(), src)
	dest = path.resolve(process.cwd(), dest)
	const dir = await fs.readdir(src)
	const skip = [
		'node_modules',
		'.git',
		'.idea'
	]
	for (let file of dir) {
		if (!~skip.indexOf(file)) {
			await fs.copy(src + '/' + file, dest + '/' + file)
		}
	}
	console.log('Copied')
}


main()
	.then(() => process.exit(0))
	.catch(error => {
		console.error(error);
		process.exit(1);
	});


