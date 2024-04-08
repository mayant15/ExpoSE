// const X = require('./lib/S$/src/symbols').symbol('X', 'hello')
//
// if (X.charCodeAt(2) === 109) {
//   throw Error('X was null')
// }

// const S$ = require('S$');
// const s = S$.symbol('s', 'x');
//
// if (s.replace('', '').length) {
//     throw 'Has length'
// } else {
//     throw 'Nope'
// }

const sym = require('./lib/S$/src/symbols').symbol

const X = sym('X', 'heeeeello')

function isCharAt(s, c, i) {
  return s.charAt(i) === c
}

/**
 * Find the first occurrence of a character in a string
 *
 * @param {string} s 
 * @param {string} char 
 */
function find(s, char) {
  // let i = 0;
  let i = sym('I', 0)
  let char_ = sym('C', char)
  while (i < s.length) {
    if (isCharAt(s, char_, i)) {
      return i
    }
    i = i + 1;
  }
  return -1;
}

const pos = find(X, 'l')
if (pos < 3) {
  throw Error('bad')
} else {
  console.log('good')
}

