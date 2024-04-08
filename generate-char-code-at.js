const start = 0;
const end = 255;

let expression = `(ite (= c (str.from_code ${end})) ${end} -1)`
for (let i = end - 1; i >= start; i = i - 1) {
  expression = `(ite (= c (str.from_code ${i})) ${i} ${expression})`
}

const result = `const charCodeAt = \`(define-fun str.charCodeAt ((s String) (i Int)) Int (let ((c (str.at s i))) ${expression}))\`;

export default charCodeAt;

`

console.log(result)
