(require 'cl)

(setq my-home-dir (concat "/home/gabor/"))
(setq my-emacs-modes (concat my-home-dir "emacsx/"))
(add-to-list 'load-path my-emacs-modes)
(add-to-list 'load-path (concat my-emacs-modes "cc-mode/"))

;;;============================================================
;;; Nxml
;;;============================================================

;; (load (concat my-emacs-modes "nxml-mode-20041004/rng-auto.el"))
;; (setq auto-mode-alist
;;       (cons '("\\.\\(xml\\|xsl\\|rng\\|xhtml\\)\\'" . nxml-mode)
;;             auto-mode-alist))
;;;============================================================
;;; ECB, CEBET
;;;============================================================

;;(load-file (concat my-emacs-modes "cedet/common/cedet.el"))
;; * This enables the database and idle reparse engines
;;(semantic-load-enable-minimum-features)
;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;(semantic-load-enable-code-helpers)
;; * This enables even more coding tools such as the nascent intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-guady-code-helpers)

;; * This turns on which-func support (Plus all other code helpers)
;; (semantic-load-enable-excessive-code-helpers)

;; This turns on modes that aid in grammar writing and semantic tool
;; development.  It does not enable any other features such as code
;; helpers above.
;; (semantic-load-enable-semantic-debugging-helpers)

;;(add-to-list 'load-path (concat my-emacs-modes "ecb/"))
;;(require 'ecb)
;;(require 'ecb-autoloads)


;;;============================================================
;;; slink
;;;============================================================

(defun slink-wiki-convert-html ()
  "Convert wiki markup to HTML"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\[\\(http:[^ ]+\\) \\(.*?\\)\\]" nil t)
      (replace-match "<a href=\"\\1\">\\2</a>"))))

(defun slink-email-to-html ()
  "Convert email addresses to HTML markup"
  (interactive)
  (save-excursion
    (if (re-search-backward "\\b" nil t)
        (if (re-search-forward "\\([.@_a-zA-Z0-9-]+\\)\\b" nil t)
            (replace-match "<a rel=\"email\" href=\"mailto:\\1\">\\1</a>")))))

(defun slink-css-publish-css (buffer)
  "Backup raw stylesheet and generate compressed CSS"
  (interactive
   (list (buffer-name)))
  (write-file "stylesheet-raw.css")
  (slink-insert-copyright-webma
   (slink-js-compress buffer))
  (write-file "stylesheet.css")
  (kill-buffer "stylesheet-raw.css")
  (kill-buffer "stylesheet.css"))

;;;============================================================
;;; W3M
;;;============================================================
   
(defun slink-w3m-push-button (label)
  (save-excursion
    (goto-char (point-min))
    (and (eq (current-buffer) (w3m-alive-p))
         (search-forward label nil t)
         (thing-at-point-url-at-point)
         (w3m-view-this-url (thing-at-point-url-at-point)))))

(defun slink-gmail-mail-archive ()
  (interactive)
  (slink-w3m-push-button "4  Archiv"))

(defun slink-gmail-mail-star ()
  (interactive)
  (slink-w3m-push-button "6  Add sta"))

(defun slink-gmail-mail-unstar ()
  (interactive)
  (slink-w3m-push-button "6  Remove sta"))

(defun slink-gmail-mail-delete ()
  (interactive)
  (slink-w3m-push-button "7  Tras"))

(defun slink-gmail-view-inbox ()
  (interactive)
  (slink-w3m-push-button "0  Inbo"))

(defun slink-gmail-view-starred ()
  (interactive)
  (slink-w3m-push-button "   Starre"))

(defun slink-sztaki-phrase-lookup ()
  "Look up the phrase under cursor in SZTAKI and echo translation if any."
  (interactive)
  (let* ((phrase (downcase (thing-at-point 'word)))
         (url (concat "http://szotar.sztaki.hu/dict_search.php"
                      "?O=HUN&E=1&L=ENG%3AHUN%3AEngHunDict&in_emacs=1&W="
                      (w3m-url-encode-string phrase)))
         (match (format "phrase '%s' not found" phrase)))
    (with-temp-buffer
      (w3m-process-with-wait-handler
        (w3m-retrieve-and-render url nil nil nil nil handler))
      (when (re-search-forward (concat phrase ":.*") nil t)
        (setq match (match-string 0))))
    (message (concat "SZTAKI: " match))))

(global-set-key (kbd "C-?") 'slink-sztaki-phrase-lookup)

(defun slink-delicious-url ()
  "Post either the url under point or the url of the current w3m page to delicious."
  (interactive)
  (let ((w3m-async-exec nil))
    (if (thing-at-point-url-at-point)
        (unless (eq (current-buffer) (w3m-alive-p))
          (w3m-goto-url (thing-at-point-url-at-point))))
    (w3m-goto-url
     (concat "http://del.icio.us/nyuhuhuu?"
             "url="    (w3m-url-encode-string w3m-current-url)
             "&title=" (w3m-url-encode-string w3m-current-title)))))

(defun slink-weblabor-blogmark ()
  "Blogmark either the url under point or the url of the current w3m page to Weblabor."
  (interactive)
  (let ((w3m-async-exec nil))
    (when (thing-at-point-url-at-point)
      (unless (eq (current-buffer) (w3m-alive-p))
        (w3m-goto-url (thing-at-point-url-at-point))))
    (w3m-goto-url
     (concat "http://weblabor.hu/blogmarkok/bekuldes/tavoli?"
             "url="    (w3m-url-encode-string
                        (read-string "URL: " w3m-current-url))
             "&title=" (w3m-url-encode-string
                        (read-string "Title: " w3m-current-title))
             "&comment=" (w3m-url-encode-string
                          (read-string "Comment: "))
             "&publish=0#maincontent"))))

(add-to-list 'load-path (concat my-emacs-modes "emacs-w3m"))
(require 'w3m-load)
(require 'w3m-session)

(setq
 w3m-use-cookies t
 w3m-cookie-accept-bad-cookies t
 w3m-output-coding-system 'utf-8
 w3m-coding-system 'utf-8
 w3m-default-coding-system 'utf-8)

(global-set-key (kbd "<f5>") 'w3m-session-select)
;(define-key w3m-mode-map (kbd "C-c b") 'slink-weblabor-blogmark)
;(define-key w3m-mode-map (kbd "C-c a") 'slink-delicious-url)
(define-key w3m-mode-map (kbd "C-c s") 'slink-gmail-mail-star)
(define-key w3m-mode-map (kbd "C-c u") 'slink-gmail-mail-unstar)
(define-key w3m-mode-map (kbd "C-c a") 'slink-gmail-mail-archive)
(define-key w3m-mode-map (kbd "C-c t") 'slink-gmail-mail-delete)
(define-key w3m-mode-map (kbd "C-c 0") 'slink-gmail-view-inbox)
(define-key w3m-mode-map (kbd "C-c 1") 'slink-gmail-view-starred)
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
    (switch-to-buffer "*w3m*<3>")))

;;;============================================================
;;; slink extensions
;;;============================================================

(defun uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (car kill-ring)) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))

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
;;; Outline
;;;============================================================

(add-hook 'outline-minor-mode-hook
          (lambda ()
            (require 'outline-magic)
            (define-key outline-minor-mode-map (kbd "<backtab>") 'outline-cycle)))

;;;============================================================
;;; SLIME \w SBCL
;;;============================================================

;(add-to-list 'load-path (concat my-home-dir "dev/slime/"))
;(setq inferior-lisp-program "/usr/bin/sbcl")
;(require 'slime)
;(slime-setup)

;;;============================================================
;;; Twitter
;;;============================================================

(require 'twit)

;;;============================================================
;;; Wordpress blogging
;;;============================================================
(add-to-list 'load-path (concat my-emacs-modes "weblogger"))
(require 'weblogger)

;;;============================================================
;;; WebMa
;;;============================================================
(defun run-webma ()
  (interactive)
  (let ((i2-dir "mnt/i2/tools/elisp"))
    (when (file-exists-p (concat my-home-dir i2-dir "/webma-mode.el"))
      (add-to-list 'load-path (concat my-home-dir i2-dir))
      (require 'webma-mode))))
(run-webma)

;;;============================================================
;;; Spell checking
;;;============================================================

(require 'ispell)

(setq ispell-program-name "hunspell"
      ispell-local-dictionary "hu_HU"
      ispell-skip-html t
      ispell-local-dictionary-alist
      '(("hu_HU" "[A-Za-z]" "[^A-Za-z]" "[']" nil nil nil iso-8859-2)))

;;;============================================================
;;; iswitchb
;;;============================================================
(require 'iswitchb)
(iswitchb-mode 1)
(add-to-list 'iswitchb-buffer-ignore "^ ")
(add-to-list 'iswitchb-buffer-ignore "*vc*")
(add-to-list 'iswitchb-buffer-ignore "*Messages*")
(add-to-list 'iswitchb-buffer-ignore "*erc-server-buffer*")
(add-to-list 'iswitchb-buffer-ignore "*Buffer")
(add-to-list 'iswitchb-buffer-ignore "*Completions")
(add-to-list 'iswitchb-buffer-ignore "^[tT][aA][gG][sS]$")

;;;============================================================
;;; GNEVE
;;;============================================================
;(add-to-list 'load-path (concat my-home-dir "dev/webma/lisp/gneve-webma-dev/"))
;(require 'gneve)

;;;============================================================
;;; Color theme
;;;============================================================
(add-to-list 'load-path (concat my-emacs-modes "color-theme-6.6.0/"))
(require 'color-theme)
(color-theme-initialize)
(color-theme-bharadwaj)

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
;; (require 'erc)
;; (require 'erc-track)
;; (add-hook 'erc-mode-hook '(lambda ()
;;                             (erc-notify-mode t)
;;                             (erc-smiley-mode t)
;;                             (erc-completion-mode t)
;;                             (erc-hide-timestamps)
;;                             (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT"))
;;                             (setq erc-autojoin-channels-alist '(("freenode.net" "#emacs")))))
;; (erc-track-mode t)
;; (erc-autojoin-mode t)
;; (setq erc-nick "nyuhuhuu"
;;       erc-prompt-for-password t
;;       erc-server "irc.freenode.org"
;;       erc-user-full-name "slink"
;;       erc-email-userid "slink")

;;;============================================================
;;; light-symbol-mode
;;;============================================================
;;(load (concat my-emacs-modes "light-symbol.el"))

;;;============================================================
;;; Elscreen
;;;============================================================
;;(add-to-list 'load-path "/home/gabor/emacsx/apel/")
;;(load "/home/gabor/emacsx/elscreen.el" "ElScreen" t)

;;;============================================================
;;; Coding standard
;;;============================================================

(set-default 'tab-width 4)
(set-default 'c-set-style 'stroustrup)
(set-default 'c-tab-width 4)
(set-default 'c-basic-offset 4)
(set-default 'c-hanging-comment-ender-p nil)
(set-default 'indent-tabs-mode nil)
(set-default 'tab-always-indent t)

;;;============================================================
;;; Python
;;;============================================================

(add-to-list 'load-path (concat my-emacs-modes "python-mode-1.0"))
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode)
                                   interpreter-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)

(add-hook 'python-mode-hook 'my-python-hook)

;; this gets called by outline to deteremine the level. Just use the length of the whitespace
(defun py-outline-level ()
  (let (buffer-invisibility-spec)
    (save-excursion
      (skip-chars-forward "\t ")
      (current-column))))

;; this get called after python mode is enabled
(defun my-python-hook ()
  ;; outline uses this regexp to find headers. I match lines with no indent and indented "class"
  ;; and "def" lines.
  (setq outline-regexp "[^ \t]\\|[ \t]*\\(def\\|class\\) ")
  ;; enable our level computation
  (setq outline-level 'py-outline-level)
  ;; do not use their \C-c@ prefix, too hard to type. Note this overides some python mode bindings
  (outline-minor-mode t)
  ;; I use CUA mode on the PC so I rebind these to make the more accessible
  (local-set-key [?\C-\t] 'py-shift-region-right)
  (local-set-key [?\C-\S-\t] 'py-shift-region-left))

;;;============================================================
;;; PHP
;;;============================================================
;;(autoload 'php-mode "php-mode" "PHP editing mode" t)
;;(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

(add-to-list 'load-path (concat my-emacs-modes "php-mode/"))
(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))

;;;============================================================
;;; Flymake PHP
;;;============================================================
(require 'flymake-php)
(set-face-attribute 'flymake-errline nil
                    :underline "red4"
                    :weight 'bold)
;(set-face-foreground 'flymake-errline "white")
(set-face-background 'flymake-warnline "dark slate blue")
(add-hook 'php-mode-hook 'flymake-php-load)

;;;============================================================
;;; Flymake shell
;;;============================================================
(require 'flymake-shell)
(add-hook 'sh-mode-hook 'flymake-shell-load)

;;;============================================================
;;; Flymake JS / JavaScript
;;;============================================================

(require 'js2-mode)
(autoload 'js2-mode "js2" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(setq js2-basic-offset 4)
(setq js2-use-font-lock-faces t)

;; (require 'flymake-js)
;; (add-hook 'java-mode-hook 'flymake-js-load)
;; (eval-after-load 'java-mode (lambda ()
;;                               (setq c-set-style "stroustrup")))

(defun slink-insert-copyright-webma (buffer)
  "Inserts copyright message in the end of BUFFER."
  (interactive
   (list (buffer-name)))
  (switch-to-buffer buffer)
  (save-excursion
    (goto-char (point-max))
    (insert "\n/* Copyright (c) 1997-2008 WebMa. */")))

(defun slink-js-compress (file-name)
  "Compress JavaScript or CSS code in file FILE-NAME and display output in a new buffer.  File type decided by file name extension."
  (interactive
   (list (or (buffer-file-name)
             (error "Buffer `%s' not visiting file" (buffer-name)))))
  (let* ((type (file-name-extension file-name))
         (pth (concat my-home-dir "dev/yuicompressor-2.2.5/build/yuicompressor-2.2.5.jar"))
         (cmd (format "java -jar %s --charset utf-8 --type %s %s" pth type file-name))
         (output-buffer (concat (buffer-name) "-min")))
    ;; Valid extensions are '.js' and '.css'
    (if (or (string= "js" type)
            (string= "css" type))
        ()
      (error "Invalid file `%s' specified" file-name))
    (shell-command cmd output-buffer)
    (pop-to-buffer output-buffer)))

(defun slink-js-function-show-args ()
  (interactive)
  (save-excursion
    (backward-char 2)
    (re-search-backward "^\\(.+\\)\\| \\(.+\\)")
    (let ((func (or (match-string 1)
                    (match-string 2))))
      (goto-char (point-min))
      (when (search-forward (concat "function " func) nil t)
        (backward-sexp 2)
        (looking-at "\\(.*\\){")
        (message (match-string 1))))))

;;;============================================================
;;; htaccess
;;;============================================================
(require 'apache-mode)

;;;============================================================
;;; Iciclse
;;;============================================================
;;(add-to-list 'load-path "/home/gabor/emacsx/icicles")
;;(load "/home/gabor/emacsx/icicles/icicles.el")

(unify-8859-on-decoding-mode)

(global-set-key "\r" 'reindent-then-newline-and-indent)

(setq backup-directory-alist (list (cons ".*" (expand-file-name
                                               "~/bkp/emacs/")))
      ;; Do not lose word wrapping if split windows
      truncate-partial-width-windows nil
      frame-title-format "Emacs - %b %*"
      delete-auto-save-files t
      inhibit-splash-screen t)

(setq custom-file "~/.emacs-custom.el")
(load custom-file 'noerror)

;;;============================================================
;;; Frame and color settings
;;;============================================================
(global-set-key (kbd "<f1>") (lambda ()
                               (interactive)
                               (set-default-font "Envy Code R-13")))
(global-set-key (kbd "<f2>") (lambda ()
                               (interactive)
                               (set-default-font "Monaco-9")))

(setq default-frame-alist
      (append
       '((font . "Monaco-9")
         (width . 81) (height . 36)
         (cursor-color . "#ffa200")
         (cursor-type . bar)
         (tool-bar-lines . 0))
       default-frame-alist))

(when window-system
  (set-default-font "Monaco-9")
  ;(set-cursor-color "#ffa200")
  ;(set-face-background 'hl-line "#ccc")
  ;(set-face-background 'hl-line "#222")
  )
    
;;;============================================================
;;; save desktop
;;;============================================================
;; save a list of open files in ~/.emacs.desktop
;; save the desktop file automatically if it already exists
;; (setq desktop-save 'if-exists)
;; (desktop-save-mode t)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
;; (setq desktop-globals-to-save
;;       (append '((extended-command-history . 30)
;;                 (file-name-history        . 100)
;;                 (grep-history             . 30)
;;                 (compile-history          . 30)
;;                 (minibuffer-history       . 50)
;;                 (query-replace-history    . 60)
;;                 (read-expression-history  . 60)
;;                 (regexp-history           . 60)
;;                 (regexp-search-ring       . 20)
;;                 (search-ring              . 20)
;;                 (shell-command-history    . 50)
;;                 tags-file-name
;;                 register-alist)))

(put 'downcase-region 'disabled nil)

;; mouse mode
(mouse-avoidance-mode 'cat-and-mouse)

;; ndash key binding
(global-set-key (kbd "C--")
                (lambda ()
                  (interactive)
                  (insert "–")))

(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(defun scroll-up-in-place (n)
  (interactive "p")
  (scroll-up n))

(defun scroll-down-in-place (n)
  (interactive "p")
  (scroll-down n))

(define-key global-map [(shift next)] 'scroll-up-in-place)
(define-key global-map [(shift prior)] 'scroll-down-in-place)

(global-set-key (kbd "<C-right>") 'forward-sexp)
(global-set-key (kbd "<C-left>") 'backward-sexp)

(global-linum-mode t)

(provide '.emacs)

;(eval-after-load '.emacs (twit-follow-recent-tweets))

;;; .emacs ends here
