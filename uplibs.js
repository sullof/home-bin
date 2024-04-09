
const exec = require('child-process-promise').exec
let libv, configv, sherpav

exec('ynpm info fhero-lib versions')
	.then(results => {
		libv = eval(results.stdout).pop()
		return exec('ynpm info fhero-config versions')
	})
	.then(results => {
		configv = eval(results.stdout).pop()
		return exec('ynpm info fhero-sherpa versions')
	})
	.then(results => {
		sherpav = eval(results.stdout).pop()
		console.log(`Removing current versions of fhero-sherpa fhero-config and fhero-lib`)
		return exec(`ynpm remove fhero-sherpa fhero-config fhero-lib --save`)
	})
	.then(() => {
		console.log(`Installing fhero-sherpa@${sherpav} fhero-config@${configv} fhero-lib@${libv}`)
		return exec(`ynpm install fhero-sherpa@${sherpav} fhero-config@${configv} fhero-lib@${libv} --save`)
	})
	.then(() => {
		console.log('Done')
	})
	.catch(err => {
		console.log(err)
	})
