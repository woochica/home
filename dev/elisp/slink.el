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
  (browse-url (concat php-search-url (current-word t) "#function." (replace-regexp-in-string "_" "-" (current-word t)))))

(defun html-to-bbcode ()
  "Convert HTML to BBCode markup in current buffer.

Unrecognized elements are ignored."
  (interactive)
  (let ((pattern-list
         '(("<a href=\"\\(.*?\\)\">\\(.*?\\)</a>" . "[url=\\1]\\2[/url]")
           ("<em>\\(.*?\\)</em>" . "[i]\\1[/i]")
           ("<var>\\(.*?\\)</var>" . "[code]\\1[/code]")
           ("<code>\\(.*?\\)</code>" . "[code]\\1[/code]")
           ("<blockquote>\\(\\(.\\|\n\\)*?\\)</blockquote>" . "[quote]\\1[/quote]")
           ("<pre class=\"\\(.*?\\)\">\\(\\(.\\|\n\\)*?\\)</pre>" . "[colorer=\\1]\\2[/colorer]")
           ("<p>\\(.*?\\)</p>" . "\\1"))))
    (mapcar (lambda (pair)
              (goto-char (point-min))
              (while (re-search-forward (car pair) nil t)
                (replace-match (cdr pair))))
            pattern-list)))

(defun slink/uniq-lines (beg end)
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

(defun slink/delicious-url ()
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

(defun slink/weblabor-blogmark ()
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

(defun insert-time ()
  "Insert a time-stamp according to locale's date and time format."
  (interactive)
  (insert (format-time-string "%Y%m%d" (current-time))))

(global-set-key (kbd "C-c i")  'insert-time)


;; SlickCopy
;; http://www.emacswiki.org/emacs/SlickCopy
(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (message "Copied line")
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(provide 'slink)
