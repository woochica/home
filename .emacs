(require 'cl)
(defalias 'docstyle 'checkdoc)

(let* ((my-home-dir "/home/gabor/")
       (my-emacs-modes (concat my-home-dir "emacsx/")))
  (add-to-list 'load-path my-emacs-modes)
  (add-to-list 'load-path (concat my-emacs-modes "cc-mode/"))
  (add-to-list 'load-path (concat my-emacs-modes "emacs-w3m/"))
  (add-to-list 'load-path (concat my-emacs-modes "color-theme-6.6.0/"))
  (add-to-list 'load-path (concat my-emacs-modes "weblogger/"))
  (add-to-list 'load-path (concat my-home-dir "dev/webma/elisp/"))
  (add-to-list 'load-path (concat my-home-dir "dev/slime/")))

;;;============================================================
;;; W3M
;;;============================================================

(require 'w3m-load)
(require 'w3m-session)

(add-hook 'w3m-load-hook (lambda ()
                           (setq
                            w3m-use-cookies t
                            w3m-cookie-accept-bad-cookies t
                            w3m-output-coding-system 'utf-8
                            w3m-coding-system 'utf-8
                            w3m-default-coding-system 'utf-8)
                           (define-key w3m-mode-map (kbd "M-1")
                             (lambda ()
                               (interactive)
                               (switch-to-buffer "*w3m*")))
                           (define-key w3m-mode-map (kbd "M-2")
                             (lambda ()
                               (interactive)
                               (switch-to-buffer "*w3m*<2>")))
                           (define-key w3m-mode-map (kbd "M-3")
                             (lambda ()
                               (interactive)
                               (switch-to-buffer "*w3m*<3>")))))

(global-set-key (kbd "<f5>") 'w3m-session-select)

;;;============================================================
;;; EMMS
;;;============================================================

;; (add-to-list 'load-path (concat my-emacs-modes "emms-3.0/"))
;; (require 'emms)
;; (require 'emms-browser)
;; (require 'emms-cache)
;; (require 'emms-info)
;; (require 'emms-lastfm)
;; (require 'emms-player-mpd)
;; (require 'emms-playing-time)
;; (require 'emms-playlist-mode)
;; (require 'emms-streams)
;; (require 'emms-tag-editor)
;; (require 'emms-volume)
;; (require 'emms-setup)
;; (require 'emms-info-libtag)
;; (require 'emms-info-mp3info)
;; (require 'emms-player-mpg321-remote)

;; (emms-devel)
;; (emms-default-players)

;; (add-to-list 'emms-info-functions 'emms-info-mp3info)
;; (add-to-list 'emms-info-functions 'emms-info-libtag)

;; ;; Last FM
;; (setq emms-lastfm-username "nyuhuhuu"
;;       emms-lastfm-password nil)

;; (add-hook 'emms-player-started-hook 'emms-show)
;; (setq emms-player-mpg321-parameters '("-o" "alsa")
;;       emms-source-file-default-directory (concat my-home-dir "Desktop/MusicLibrary/")
;;       emms-info-asynchronously t
;;       later-do-interval 0.0001
;;       emms-mode-line-format " %s "
;;       emms-show-format "Ez szól: %s"
;;       emms-browser-default-covers
;;       (list "/home/gabor/share/cover_small.jpg" nil nil))

;; ;; let compilation tracks be displayed together
;; (setq emms-browser-get-track-field-function
;;       'emms-browser-get-track-field-use-directory-name)

;; (global-set-key (kbd "<f1>") 'emms-lastfm-np)
;; (global-set-key (kbd "<XF86AudioPrev>") 'emms-previous)
;; (global-set-key (kbd "<XF86AudioNext>") 'emms-next)
;; (global-set-key (kbd "<XF86AudioPlay>") (lambda ()
;; 					   (interactive)
;; 					   (if emms-player-playing-p
;; 					       (emms-pause)
;; 					     (emms-start))
;; 					   (emms-show)))

;; (setq emms-browser-covers '("Folder.jpg" "front.jpg" "cover.jpg" "folder.jpg" "Front.jpg"))

;; (setq emms-browser-info-title-format "%i%cS%n")
;; (setq emms-browser-playlist-info-title-format
;;       emms-browser-info-title-format)

;;;============================================================
;;; LISP
;;;============================================================

(setq inferior-lisp-program "/usr/bin/sbcl")
(add-hook 'inferior-lisp-mode-hook (lambda ()
                                     (require 'slime)
                                     (slime-setup)))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key (kbd "<backtab>") 'lisp-complete-symbol)))

;;;============================================================
;;; Twitter
;;;============================================================

(require 'twit)
(add-hook 'twit-new-tweet-hook
          (lambda ()
            (let* ((user (cadr twit-last-tweet))
                   (msg (caddr twit-last-tweet))
                   (cmd "/usr/bin/notify-send")
                   (args (format "-i twitter.png \"%s:\" \"%s\"" user msg)))
              (if (string= twit-user user)
                  ()
                (call-process-shell-command cmd nil t nil args)))))

;;;============================================================
;;; HTML
;;;============================================================

(add-to-list 'auto-mode-alist '("\\.html?\\'" . nxml-mode))
(add-hook 'nxml-mode-hook (lambda ()
                            (rng-validate-mode nil)
                            (webma-html-mode t)))

;;;============================================================
;;; CSS
;;;============================================================

(add-hook 'css-mode-hook (lambda ()
                           (webma-css-mode t)))

;;;============================================================
;;; Wordpress blogging
;;;============================================================

(require 'weblogger)

;;;============================================================
;;; Spell checking
;;;============================================================

(require 'ispell)

(setq ispell-program-name "hunspell"
      ispell-local-dictionary "hu_HU.UTF-8"
      ispell-skip-html t
      ispell-local-dictionary-alist
      '(("hu_HU" "[A-Za-z]" "[^A-Za-z]" "[']" nil nil nil utf-8)))

;;;============================================================
;;; Smart buffer switch and file find
;;;============================================================

(require 'ido)
(ido-mode t)
(add-to-list 'ido-ignore-buffers "*Messages")
(add-to-list 'ido-ignore-buffers "*Completions")
(add-to-list 'ido-ignore-buffers "*Customiz")
(add-to-list 'ido-ignore-buffers "*Help")
(add-to-list 'ido-ignore-buffers "*vc")

;;;============================================================
;;; Server
;;;============================================================

(unless (string-equal "root" (getenv "USER"))
  (when (or (not (boundp 'server-process))
            (not (eq (process-status server-process)
                     'listen)))
    (server-start)))

;;;============================================================
;;; ERC
;;;============================================================

(require 'erc)
(require 'erc-track)

(add-hook 'erc-mode-hook (lambda ()
                           (erc-scrolltobottom-mode t)
;;                           (erc-track-mode t)
;;                           (erc-smiley-mode t)
;;                           (erc-timestamp-mode nil)
;;                            (erc-notify-mode t)
;;                            (erc-autojoin-mode t)
;;                            (erc-completion-mode t)))
))
                           
(setq erc-server "irc.freenode.org"
      erc-port 6667 
      erc-nick "nyuhuhuu"
      erc-prompt-for-password t
      erc-user-full-name "slink"
      erc-email-userid "slink"
;;       erc-autojoin-channels-alist '(("freenode.net" "#emacs"))
       erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"))
      
;;;============================================================
;;; Programming
;;;============================================================

(set-default 'c-set-style 'stroustrup)
(set-default 'c-tab-width 4)
(set-default 'c-basic-offset 4)
(set-default 'c-hanging-comment-ender-p nil)
(set-default 'indent-tabs-mode nil)
(set-default 'tab-always-indent t)
(global-linum-mode t)

;;;============================================================
;;; Python
;;;============================================================

(require 'python)

;;;============================================================
;;; PHP
;;;============================================================

(require 'php-mode)
(require 'flymake-php)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-hook 'php-mode-hook 'flymake-php-load)
                           
;;;============================================================
;;; Shell programming
;;;============================================================

(require 'flymake-shell)
(add-hook 'sh-mode-hook 'flymake-shell-load)

;;;============================================================
;;; JavaScript
;;;============================================================

(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\(on\\)?$" . js2-mode))
(add-hook 'js2-mode-hook (lambda ()
                           (webma-js-mode t)
                           (local-set-key (kbd "<backtab>") 'hippie-expand)
                           (setq js2-basic-offset 4
                                 js2-use-font-lock-faces t)))

;;;============================================================
;;; slink
;;;============================================================

(require 'slink)

;;;============================================================
;;; work
;;;============================================================

(require 'webma)
(require 'webma-html)
(require 'webma-css)
(require 'webma-js)
(require 'webma-instance)

(global-set-key (kbd "C-c w s") 'webma-instance-session-start)
(global-set-key (kbd "C-c w c") 'webma-instance-session-close)
(global-set-key (kbd "C-c w r") 'webma-instance-session-render)
(global-set-key (kbd "C-c w i") 'webma-instance-idb-update)

;;;============================================================
;;; Frames, colors, misc.
;;;============================================================

(require 'color-theme)
(color-theme-initialize)
;(color-theme-arjen)
(color-theme-bharadwaj)

(setq default-frame-alist
      (append
       '((font . "Monaco-9")
         (width . 82) (height . 36)
         (cursor-color . "#ffa200")
         (cursor-type . bar)
         (tool-bar-lines . 0))
       default-frame-alist))

(setq backup-directory-alist (list
                              (cons ".*" (expand-file-name "~/bkp/emacs/")))
      truncate-partial-width-windows nil ;; don't lose word wrapping if split
                                         ;; windows
      frame-title-format "Emacs - %b %*"
      delete-auto-save-files t
      inhibit-splash-screen t
      custom-file "~/.emacs-custom.el")
(load custom-file 'noerror)

(mouse-avoidance-mode 'cat-and-mouse)

(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(global-set-key [(shift next)] (lambda (n)
                                 (interactive "p")
                                 (scroll-up n)))
(global-set-key [(shift prior)] (lambda (n)
                                  (interactive "p")
                                  (scroll-down n)))
(global-set-key "\r" 'reindent-then-newline-and-indent)
(global-set-key (kbd "C--") (lambda ()
                              (interactive)
                              (insert "–")))
(global-set-key (kbd "<C-right>") 'forward-sexp)
(global-set-key (kbd "<C-left>") 'backward-sexp)

(provide '.emacs)

;;; .emacs ends here
