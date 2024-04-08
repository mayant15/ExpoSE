(declare-fun X () String)

;(declare-fun indexOf (String String) Int)

(define-fun-rec indexOf ((s String) (ch String)) Int (ite (= (str.len s) 0) -1 (ite (= (str.at s 0) ch) 0 (let ((sub (indexOf (str.substr s 1 (- (str.len s) 1)) ch))) (ite (= sub -1) -1 (+ sub 1)))) ))

(assert (= (indexOf X "2") 4))

(check-sat)
(get-model)

