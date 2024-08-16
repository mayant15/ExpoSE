const X = require('../../lib/S$/src/symbols').symbol('X', 41)

if (X + 3 === 45) throw Error('bad')
// if (X + 3 !== 50) throw Error('bad')
// ok
