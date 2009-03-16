(eval-when-compile (require 'cl))

(defvar emacs-root "/home/gabor/")
(defvar emacs-mode-directory (concat emacs-root "dev/elisp/"))

(add-to-list 'load-path emacs-mode-directory)
(add-to-list 'load-path (concat emacs-mode-directory "yasnippet/"))
(add-to-list 'load-path (concat emacs-mode-directory "emms-tsdh"))
(add-to-list 'load-path (concat emacs-mode-directory "emacs-w3m"))
(add-to-list 'load-path (concat emacs-mode-directory "ejacs"))
(add-to-list 'load-path (concat emacs-mode-directory "slime"))
(add-to-list 'load-path "~/dev/slink/elisp/flymake-shell")
(add-to-list 'load-path (concat emacs-mode-directory "auto-complete"))

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

(require 'auto-complete)

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
            (flymake-mode 1)
            (setq php-warned-bad-indent t
                  c-basic-offset 4)))

;;;============================================================
;;; VC, Git
;;;============================================================

(require 'git "/usr/share/emacs/site-lisp/git.el")
(require 'psvn "/usr/share/emacs/site-lisp/psvn.el")

;;;============================================================
;;; JavaScript
;;;============================================================

(require 'js2-mode (concat emacs-mode-directory "js2-mode/build/js2"))
(autoload 'js-console "js-console" nil t)

;;;============================================================
;;; Shell
;;;============================================================

(require 'flymake-shell)
(add-hook 'sh-mode-hook 'flymake-shell-load)

;;;============================================================
;;; Spelling
;;;============================================================

(require 'ispell)
(setq ispell-local-dictionary-alist
      '((
         ;; add US english as local dictionary
         "en_US" "\[\[:alpha:\]\]" "[^[:alpha:]]" "[']" nil
         ("-d" "en_US") nil utf-8)
        ;; add hungarian as local dictionary
        ("hu_HU" "\[\[:alpha:\]\]" "[^[:alpha:]]" "[']" nil
         ("-d" "hu_HU") nil utf-8)))

(ispell-change-dictionary "hu_HU" t)

;;;============================================================
;;; slink
;;;============================================================

(require 'slink)

;;;============================================================
;;; Work
;;;============================================================

(load (concat emacs-root "dev/webma/elisp/init.el"))

;;;============================================================
;;; Typo
;;;============================================================

(require 'typopunct)
(add-to-list 'typopunct-language-alist
             `(hungarian ,(decode-char 'ucs #x201E)
                         ,(decode-char 'ucs #x201D)
                         ,(decode-char 'ucs #xBB)
                         ,(decode-char 'ucs #xAB)))
(typopunct-change-language 'hungarian t)

;;;============================================================
;;; Which function
;;;============================================================

(require 'which-func)

;; enable mode for HTML editing
(add-to-list 'which-func-modes 'html-mode)
(add-to-list 'which-func-modes 'nxhtml-mode)
(add-to-list 'which-func-modes 'nxhtml-mumamo-mode)

;; Put function name to header-line
(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq which-func-header-line-format
              '(which-func-mode
                ("" which-func-format)))

(defadvice which-func-ff-hook (after header-line activate)
  (when which-func-mode
    (delete (assoc 'which-func-mode mode-line-format) mode-line-format)
    (setq header-line-format which-func-header-line-format)))

(which-func-mode 1)

;;;============================================================
;;; Frames, colors, misc.
;;;============================================================

(require 'color-theme)
(load-file "~/dev/elisp/color-theme-blue.el")
;;(color-theme-blue)
(color-theme-zenburn)

(setq default-frame-alist
      (append
       '((font . "Monaco-11")
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

;; Change dictionary for spell checking
(global-set-key [f12] (lambda ()
                        (interactive)
                        (let ((flyspell-p flyspell-mode))
                          (and flyspell-p (flyspell-mode -1))
                          (if (ispell-change-dictionary "hu_HU" t)
                              ()
                            (ispell-change-dictionary "en_US" t))
                          (and flyspell-p (flyspell-mode 1)))))

;;@Override Emacs Starter Kit
(global-set-key (kbd "C-x h") 'mark-whole-buffer)
(global-set-key (kbd "C-x <return> c") 'universal-coding-system-argument)

;; TAB          yas/expand
;; Shift-TAB    dynamic expandation
;; Super-TAB    indentation
(global-set-key [(super tab)] 'indent-region)
(global-set-key [backtab] 'dabbrev-expand)

;; EMMS
(global-set-key (kbd "<XF86AudioLowerVolume>") 'emms-volume-lower)
(global-set-key (kbd "<XF86AudioRaiseVolume>") 'emms-volume-raise)
(global-set-key (kbd "<XF86AudioPrev>") 'emms-previous)
(global-set-key (kbd "<XF86AudioNext>") 'emms-next)

;; Others
(global-set-key "\r" 'reindent-then-newline-and-indent)

;; @Override Emacs Starter Kit
(auto-fill-mode -1)
(remove-hook 'text-mode-hook 'auto-fill-mode)

;; Use `html-mode' HTM files
(member '("\\.htm\\'" . nxhtml-mumamo-mode) auto-mode-alist)
(setq auto-mode-alist (delete '("\\.htm\\'" . nxhtml-mumamo-mode) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.htm\\'" . html-mode))

(provide '.emacs)

;;; .emacs ends here
