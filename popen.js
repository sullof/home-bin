#!/usr/bin/env node
const fs = require('fs-extra')
const path = require('path')

const [,,project] = process.argv

if (!project) {
	console.error('Please provide a project name')
	process.exit(1)
}

function pbcopy(data) {
	const proc = require('child_process').spawn('pbcopy');
	proc.stdin.write(data); proc.stdin.end();
}

async function recursivelyFindSubdirectoryPath(root, subdirectory, level) {
	const dir = await fs.readdir(root);
	for (let i = 0; i < dir.length; i++) {
		const dirpath = path.join(root, dir[i]);
		if ((await fs.lstat(dirpath)).isDirectory()) {
			let isIdeaProject = level > 1 ? await fs.pathExists(path.join(dirpath, ".idea")) : false;
			if (isIdeaProject) {
				if (dir[i] === subdirectory) {
					return dirpath;
				}
			} else {
				const result = await recursivelyFindSubdirectoryPath(dirpath, subdirectory, level + 1);
				if (result) {
					return result;
				}
			}
		}
	}
}

async function main() {
	// it search in the projects folder
	const projectsPath = path.resolve(__dirname, '../Projects');
	const dirPath = await recursivelyFindSubdirectoryPath(projectsPath, project, 1)
	console.log("dirPath", dirPath);
	if (dirPath) {
		pbcopy(`(cd ${dirPath} && idea .)`)
		console.log('String copied to clipboard!');
	}
	// execSync(`cd ${dirPath} && idea .`, {stdio: 'inherit'});
}


main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error);
		process.exit(1);
	});
