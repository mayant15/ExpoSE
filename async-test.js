const sym = require('./lib/S$/src/symbols').symbol

// const X = sym('X', 'hello')
//
// function sleep(ms) {
//   return new Promise((res) => {
//     setTimeout(_ => res('greetings '), ms)
//   })
// }
//
// sleep(500).then(pre => pre + X).then((d) => {
//   if (d.indexOf('l') > 3) {
//     console.log('bad')
//   } else {
//     console.log('good')
//   }
// })

const X = sym('X', 0)
const Y = sym('Y', 1)
// const Z = sym('Z', 2)
//
// function* MyArray() {
//   yield X + Y
//   yield Y + Z
//   yield Z + X
// }
//
// for (const val of MyArray) {
//   if (val < 0) {
//     throw Error('bad!')
//   }
// }

// const array = [...[X, Y], 2]
//
// if (array.indexOf(1) === 0) {
//   throw Error('bad')
// } else {
//   console.log('good')
// }


function myLog(msg, ...args) {
  if (args[0] === 1) {
    throw Error('bad')
  } else {
    console.log('good')
  }
}

myLog('message', ...[X, 2])
