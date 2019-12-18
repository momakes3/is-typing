# is-typings

> Get notified when user is typing in Node/Electron! (Works on macOS — Needs Accessability permission)

## Install

```
$ npm install is-typings
```

Requires macOS 10.11 or later.

## Usage

```js
const isTypingListener = require("is-typings");

isTypingListener(event => {
	if (event === "KEYDOWN") {
		console.log("a key was pressed");
	}
});
```

## Inspired

Inspired by the one and only [Sindre Sorhus](https://sindresorhus.com). Support him on his Patreon: https://www.patreon.com/sindresorhus

- [is-camera-on-cli](https://github.com/sindresorhus/is-camera-on-cli) - CLI for this module

## Support Me

https://patreon.com/morajabi

## License

MIT © [Mohammad Rajabifard](https://morajabi.im)
