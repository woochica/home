
;; Load and require
(add-to-list 'load-path (concat emacs-root "dev/webma/elisp/"))

(require 'webma)
(require 'webma-html)
(require 'webma-css)
(require 'webma-js)
(require 'webma-image)
(require 'webma-instance)

;; HTML
(add-hook 'html-mode-hook (lambda ()
                            (webma-html-mode t)))

;; CSS
(add-hook 'css-mode-hook (lambda ()
                           (webma-css-mode t)))

;; JavaScript
(add-hook 'js2-mode-hook (lambda ()
                           (webma-js-mode t)))

;; WebMa
(global-set-key (kbd "C-c w s") 'webma-instance-session-start)
(global-set-key (kbd "C-c w c") 'webma-instance-session-close)
(global-set-key (kbd "C-c w r") 'webma-instance-session-render)
(global-set-key (kbd "C-c w u") 'webma-instance-session-upload)
(global-set-key (kbd "C-c w i") 'webma-instance-idb-update)
