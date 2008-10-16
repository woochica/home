(require 'elunit)
(require 'slink)

(eval-when-compile (require 'cl))

(elunit-clear)
(define-elunit-suite slink-suite nil)
  
(define-elunit-test assertions slink-suite
  "Test assertions."
  (if (ad-is-advised 'w3m-url-transfer-encode-string)
      ()
    (ad-activate 'w3m-url-transfer-encode-string))
  (dolist (test-case '(("gábor.20y.hu"
                        "xn--gbor-5na.20y.hu")
                       ("http://gábor.20y.hu/áááá"
                        "http://xn--gbor-5na.20y.hu/%E1%E1%E1%E1")))
    (assert-equal (cadr test-case) (w3m-url-transfer-encode-string (car test-case)))))
