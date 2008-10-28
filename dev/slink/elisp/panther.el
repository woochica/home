;;; Set C style according to visiting file's directory
;;; In response to Panther's solution: http://hup.hu/node/62427

(defcustom panther/c-modes-directory-alist
  '(("/home/panther/src" "linux")
    ("/home/panther/gnu" "gnu"))
  "Alist of Panther's (DIRECTORY CODING-STYLE) mapping."
  :type '(alist :key-type file :value-type (group string))
  :group 'c)

(defun panther/c-set-style ()
  "Set C style according to visiting file's directory."
  (interactive)
  (mapcar (lambda (item)
            (when (string-match (car item) (buffer-file-name))
              (message "Setting C-style to '%s'" (cadr item))
              (c-set-style (cadr item)))) panther/c-modes-directory-alist))

(add-hook 'c-mode-hook 'panther/c-set-style)
