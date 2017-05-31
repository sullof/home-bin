
const exec = require('child-process-promise').exec

exec('ps aux | grep Spotify')
	.then(results => {
		let result = []
		list = results.stdout.split`\n`
		for (let i=0;i<list.length - 1; i++) {
			if (!~list[i].indexOf('grep Spotify') && !~list[i].indexOf('killSpotify')) {
				result.push(list[i].match(/ \d{4,6} /)[0].replace(/ /g, ''))
			}
		}
		console.log(result.join` `)
	})
	.catch(() => {
		// nothing
	})
