(require 'w3m-cookie)

;; (defadvice w3m-url-transfer-encode-string (around encode-idna (url &optional coding))
;;   (let* ((idna-to-ascii-parameters '("--quiet"
;;                                      "--idna-to-ascii"))
;;                                         ; Disable UseSTD3ASCIIRules flag
;;          (host (w3m-get-server-hostname
;;                 (replace-regexp-in-string "mailto:" "mailto://" url)))
;;          (url (replace-regexp-in-string host (idna-to-ascii host) url)))
;;     ad-do-it))

;; (ad-activate 'w3m-url-transfer-encode-string)
;; (ad-deactivate 'w3m-url-transfer-encode-string)

;;@override
(defun php-search-documentation ()
  "Search PHP documentation for the word at the point."
  (interactive)
  (browse-url (concat php-search-url (current-word t) "#function." (current-word t))))

(defadvice gomoku (around disable-linum-mode (&optional n m))
  (let ((linum-mode-p linum-mode))
    (if linum-mode-p
        (linum-mode nil))
    ad-do-it
    (if linum-mode-p
        (linum-mode t))))

(ad-activate 'gomoku)

(defun slink-uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments: BEG and END (region to sort)."
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
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))

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

(define-key w3m-mode-map (kbd "C-c b") 'slink-weblabor-blogmark)
(define-key w3m-mode-map (kbd "C-c a") 'slink-delicious-url)
(define-key w3m-mode-map (kbd "C-c s") 'slink-gmail-mail-star)
(define-key w3m-mode-map (kbd "C-c u") 'slink-gmail-mail-unstar)
(define-key w3m-mode-map (kbd "C-c a") 'slink-gmail-mail-archive)
(define-key w3m-mode-map (kbd "C-c t") 'slink-gmail-mail-delete)
(define-key w3m-mode-map (kbd "C-c 0") 'slink-gmail-view-inbox)
(define-key w3m-mode-map (kbd "C-c 1") 'slink-gmail-view-starred)


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

(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/su::" file)))
  (rename-buffer (concat "su::" (buffer-name))))

(defun th-find-file-sudo-maybe ()
  "Re-finds the current file as root if it's read-only after
querying the user."
  (interactive)
  (let ((file (buffer-file-name)))
    (and (not (file-writable-p file))
         (y-or-n-p "File is read-only.  Open it as root? ")
         (progn
           (kill-buffer (current-buffer))
           (th-find-file-sudo file)))))

(add-hook 'find-file-hook 'th-find-file-sudo-maybe)

(provide 'slink)
