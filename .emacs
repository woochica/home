(eval-when-compile (require 'cl))

(defvar emacs-root "/home/gabor/")
(defvar emacs-mode-directory (concat emacs-root "dev/elisp/"))

(add-to-list 'load-path emacs-mode-directory)
(add-to-list 'load-path (concat emacs-mode-directory "yasnippet/"))
(add-to-list 'load-path "/usr/share/emacs/site-lisp/") ; git, psvn
;; darcs get  http://www.tsdh.de/repos/darcs/emms/ emms-tsdh 
(add-to-list 'load-path (concat emacs-mode-directory "emms-tsdh"))
(add-to-list 'load-path (concat emacs-mode-directory "emacs-w3m"))
(add-to-list 'load-path (concat emacs-mode-directory "js2-mode"))
(add-to-list 'load-path (concat emacs-mode-directory "ejacs"))
(add-to-list 'load-path (concat emacs-mode-directory "slime"))
(add-to-list 'load-path "~/dev/slink/elisp/flymake-shell")

;;;============================================================
;;; Emacs Starter Kit
;;;============================================================

(load (concat emacs-mode-directory "emacs-starter-kit/init.el"))

;;;============================================================
;;; W3M
;;;============================================================

(require 'w3m-load)
(require 'w3m-session)

(add-hook 'w3m-mode-hook (lambda ()
                           (setq w3m-use-cookies t
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

(add-hook 'w3m-display-hook
          (lambda (url)
            (rename-buffer
             (format "*w3m: %s*" (or w3m-current-title
                                     w3m-current-url)) t)))

;;;============================================================
;;; Twitter
;;;============================================================

(require 'twit)
(add-hook 'twit-new-tweet-hook
          (lambda ()
            (let* ((user (cadr twit-last-tweet))
                   (msg (caddr twit-last-tweet))
                   (cmd "/usr/bin/notify-send")
                   (args (format "-i twitter \"%s:\" \"%s\"" user msg)))
              (if (or (string= twit-user user) (not user))
                  ()
                (call-process-shell-command cmd nil t nil args)))))

(defadvice twit-follow-recent-tweets (around get-buffer ())
  (if (bufferp (get-buffer "*Twit-recent*"))
      (pop-to-buffer "*Twit-recent*")
    ad-do-it))

(ad-activate 'twit-follow-recent-tweets)

;;;============================================================
;;; EMMS/Last.FM
;;;============================================================

(require 'emms-setup)
(emms-devel)
(emms-default-players)
(emms-lastfm-enable)

(defadvice emms-lastfm-radio (before read-passwd (lastfm-url))
  (if (string= emms-lastfm-password "")
      (setq emms-lastfm-password (read-passwd "Password: "))))

(ad-activate 'emms-lastfm-radio)

;;;============================================================
;;; Snippets
;;;============================================================

(require 'yasnippet)
(yas/initialize)
(yas/load-directory (concat emacs-mode-directory "yasnippet/snippets/"))
                                        ; factory defaults
(yas/load-directory (concat emacs-mode-directory "snippets/"))
                                        ; custom templates

;;;============================================================
;;; LISP
;;;============================================================

(setq inferior-lisp-program "/usr/bin/sbcl")

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key (kbd "<backtab>") 'lisp-complete-symbol)))

;;;============================================================
;;; PHP
;;;============================================================

(require 'php-mode)
(add-to-list 'auto-mode-alist
             '("\\.\\(module\\|install\\|engine\\|theme\\)\\'" . php-mode))

(add-hook 'php-mode-hook
          (lambda ()
            (setq php-warned-bad-indent t)))

;;;============================================================
;;; VC, Git
;;;============================================================

(require 'git)
(require 'vc-git "/home/gabor/src/emacs/lisp/vc-git.el")
(require 'psvn)

;;;============================================================
;;; JavaScript
;;;============================================================

(require 'js2-mode)
(autoload 'js-console "js-console" nil t)

;;;============================================================
;;; Shell
;;;============================================================

(require 'flymake-shell)
(add-hook 'sh-mode-hook 'flymake-shell-load)

;;;============================================================
;;; slink
;;;============================================================

(require 'slink)

;;;============================================================
;;; Work
;;;============================================================

(load (concat emacs-root "dev/webma/elisp/init.el"))

;;;============================================================
;;; Frames, colors, misc.
;;;============================================================

(color-theme-zenburn)

(setq default-frame-alist
      (append
       '((font . "Monaco-10")
         (width . 82) (height . 36)
         (cursor-color . "#ffa200")
         (cursor-type . bar)
         (tool-bar-lines . 0))
       default-frame-alist))

;;@override Emacs Starter Kit
(setq backup-directory-alist (list
                              (cons ".*" (expand-file-name "~/bkp/emacs/"))))
(setq delete-auto-save-files t)
(setq custom-file "~/.emacs-custom.el")
(load custom-file 'noerror)

(mouse-avoidance-mode 'cat-and-mouse)

(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;;;============================================================
;;; Global key bindings
;;;============================================================

;; Toggle fullscreen mode
(global-set-key [f11] (lambda ()
                        (interactive)
                        (set-frame-parameter nil 'fullscreen
                                             (if (frame-parameter nil 'fullscreen)
                                                 nil
                                               'fullboth))))

;; Clock in and out
(global-set-key [f5] 'org-clock-in)
(global-set-key [f6] 'org-clock-out)

;;@override Emacs Starter Kit
(global-set-key (kbd "C-x h") 'mark-whole-buffer)
(global-set-key (kbd "C-x <return> c") 'universal-coding-system-argument)

;; TAB          yas/expand
;; Shift-TAB    dynamic expandation
;; Super-TAB    indentation
(global-set-key [(super tab)] 'indent-region)
(global-set-key [backtab] 'dabbrev-expand)

;; Others
(global-set-key "\r" 'reindent-then-newline-and-indent)

;; Fix buggy `org-get-outline-path'
(defadvice org-get-outline-path (around fix-bug (&optional fastp level heading))
  (let ((level (or level 1)))
    ad-do-it))

(ad-activate 'org-get-outline-path)

(provide '.emacs)

;;; .emacs ends here
