#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const Case = require('case');

const [, , relativeDirPath = "."] = process.argv;
const dirPath = /\//.test(relativeDirPath) ? relativeDirPath : path.resolve(process.cwd(), relativeDirPath);

function renameFilesInDirectory(dirPath) {
	fs.readdir(dirPath, (err, files) => {
		if (err) {
			console.error(`Error reading directory: ${err}`);
			return;
		}

		files.forEach(file => {
			const filePath = path.join(dirPath, file);
			fs.stat(filePath, (err, stats) => {
				if (err) {
					console.error(`Error reading file stats: ${err}`);
					return;
				}

				if (stats.isFile()) {
					const newFileName = Case.snake(file).replace(/_(?=[^_]*$)/, '.');
					const newFilePath = path.join(dirPath, newFileName);
					fs.rename(filePath, newFilePath, err => {
						if (err) {
							console.error(`Error renaming file: ${err}`);
						} else {
							console.log(`Renamed '${file}' to '${newFileName}'`);
						}
					});
				}
			});
		});
	});
}

renameFilesInDirectory(dirPath);
