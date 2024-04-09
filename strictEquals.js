const X = require('./lib/S$/src/symbols').symbol('X', 'something')

if (X === null) {
  throw Error('')
} else {
  console.log('good')
}
