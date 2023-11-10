#!/usr/bin/env node

const path = require('path');
const moment = require('moment');
const chalk = require('chalk');

const homedir = require('homedir');

const configPath = path.join(homedir(), '.config/configstore/timetracking.json');
const config = require(configPath);

const [,, date] = process.argv;

function getWeek(date) {
	const m = moment(date);
	return m.clone().startOf('week').format().substring(0,10);
}

function countHours(start, stop) {
	start = new Date(start);
	stop = new Date(stop);
	const diff = stop.getTime() - start.getTime();
	return {
		hours: Math.round(diff / 3600000),
		minutes: Math.round(diff / 60000) % 60
	}
}

for (let task of config.tasks) {
	console.log(chalk.green("Task: "), chalk.bold(task.name));
	let weeks = {}
	for (let log of task.log) {
		let week = getWeek(log.start);
		if (!weeks[week]) {
			weeks[week]= {
				hours: 0,
				minutes: 0
			}
		}
		if (log.start && log.stop) {
			const {hours, minutes} = countHours(log.start, log.stop);
			weeks[week].hours += hours;
			weeks[week].minutes += minutes;
		}
	}
	for (let week in weeks) {
		let {hours, minutes} = weeks[week];
		hours += Math.floor(minutes / 60);
		if (hours < 10) hours = "0" + hours;
		minutes = minutes % 60;
		console.log(chalk.blue(week), `${hours}:${minutes}`);
	}
}


