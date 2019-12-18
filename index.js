"use strict";
const macosVersion = require("macos-version");
const path = require("path");
const electronUtil = require("electron-util/node");
// const execa = require("execa");
const binary = path.join(electronUtil.fixPathForAsarUnpack(__dirname), "main");
const spawn = require("child_process").spawn;

module.exports = (callback = () => {}) => {
	macosVersion.assertGreaterThanOrEqualTo("10.11");

	const child = spawn(binary, {
		encoding: "utf8"
	});

	// use event hooks to provide a callback to execute when data are available:
	child.stdout.on("data", function(data) {
		const dataStr = data
			.toString()
			.trim()
			.split("\n");

		callback(dataStr[0]);
	});

	return {
		kill: () => child.kill()
	};
};
