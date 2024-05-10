const X = require('../../lib/S$/src/symbols').symbol('X', 42)

if (X === null) {
  throw Error('null')
} else {
  // if (X === undefined) {
  //   throw Error('undefined')
  // } else {
  //   // ok!
  // }
}
