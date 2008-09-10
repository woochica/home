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
  (let ((raw-host "gábor.20y.hu")
        (raw-url "http://gábor.20y.hu/áááá")
        (idna-host "xn--gbor-5na.20y.hu")
        (idna-url "http://xn--gbor-5na.20y.hu/%E1%E1%E1%E1"))
    (assert-equal idna-host (w3m-url-transfer-encode-string raw-host))
    (assert-equal idna-url (w3m-url-transfer-encode-string raw-url))))

(elunit "slink-suite")
