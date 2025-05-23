#!/usr/bin/env node

const fs = require('fs')
const {execSync} = require('child_process')

const [,,...wl] = process.argv

function cmdExec(what) {
	try {
		return execSync(what).toString().split('\n')
	} catch(err) {
		return []
	}
}

const whiteList = [
	"master",
	"main",
	"dev",
	"staging",
	"stage"
].concat(wl)

const branches = cmdExec('git --no-pager branch')
for (let i = 0;i< branches.length;i++) {
	branches[i] = branches[i].replace(/ /g, '')
	if (!branches[i] || /\*/.test(branches[i]) || whiteList.includes(branches[i])) {
		branches.splice(i,1)
		i--
	}
}

for (let branch of branches) {
	cmdExec(`git branch -D ${branch} && git push origin --delete ${branch}`)
}

