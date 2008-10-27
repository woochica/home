(defgroup gibzo/project nil
  "Customizations for Gibzo's project management."
  :prefix "gibzo/project-"
  :group 'files)

(defcustom gibzo/project-files
  '(("config" "~/.emacs" "~/.bashrc")
    ("php" "/etc/php.ini"))
  "Alist of projects and related files.
Each element has the form (PROJECT FILE1 FILE2 [...])"
  :type '(alist :key-type string :value-type (repeat file))
  :group 'gibzo/project)

(defun gibzo/project-file-file (project)
  "Open files related to PROJECT."
  (interactive
   (list
    (completing-read "Project: " (mapcar (lambda (car)
                                           (car car)) gibzo/project-files))))
  (mapcar 'find-file (cdr (assoc project gibzo/project-files))))
