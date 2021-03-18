#!/usr/bin/env node

const fs = require('fs-extra')
const path = require('path')

async function normalizeFilenames() {
	const dir = await fs.readdir('.')
	for (let fn of dir) {
		let tmp = fn.split('.')
		let ext = tmp.pop().toLowerCase()
		let base = tmp.join('.')
		if (/[^a-zA-Z0-9]/.test(base)) {
			await fs.move(fn, base.replace(/[^a-zA-Z0-9]+/g, '-') + `.${ext}`)
		}
	}

}

normalizeFilenames()
