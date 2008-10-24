;;; rhino-minor-mode.el --- Minor mode for evaulating JavaScript expressions in Rhino.

;;; Commentary:
;; 

;;; Todos:
;; - echo reply instead of popping up window

;;; History:
;; 

;;; Code:
(defgroup rhino nil
  "Customizations for `rhino-minor-mode'."
  :prefix "rhino-"
  :group 'programming)

(defcustom rhino-java-bin-path
  "/usr/bin/java"
  "Path of Java executable."
  :type '(file :must-match t)
  :group 'rhino)

(defcustom rhino-rhino-jar-path
  "rhino.jar"
  "Path of Rhino JAR library."
  :type '(file :must-match t)
  :group 'rhino)

(defvar rhino-process-id "rhino"
  "Rhino process ID.")

(defvar rhino-minor-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\C-x\C-e" 'rhino-eval-region)
    map)
  "Map for Rhino minor mode.")

(defun rhino-eval-region (start end)
  "Evaluate expressions in region.

Called from a program, there are two arguments:
START and END (region to sort)."
  (interactive "r")
  (unless (and start end)
    (error "No active region"))
  (save-excursion
    (save-restriction
      (narrow-to-region start end)
      (process-send-string
       rhino-process-id
       ;; Expression should contain exactly one trailing newline
       ;; to avoid displaying multiple prompts in the reply
       (concat (replace-regexp-in-string "\n$" "" (buffer-string)) "\n"))))
  (pop-to-buffer rhino-process-id))

(defun rhino-start-process ()
  "Start Rhino process."
  (interactive)
  (if (file-exists-p rhino-rhino-jar-path)
      (start-process
       rhino-process-id rhino-process-id rhino-java-bin-path "-cp"
       rhino-rhino-jar-path "org.mozilla.javascript.tools.shell.Main")
    (error "Rhino JAR file not found")))

(defun rhino-stop-process ()
  "Stop Rhino process."
  (interactive)
  (kill-process rhino-process-id))

(define-minor-mode rhino-minor-mode
  "Minor mode for evaulating JavaScript expressions in Rhino.

\\{rhino-minor-mode-map}"
  :init-value nil
  :lighter " Rhino"
  (if rhino-minor-mode
      (rhino-start-process)
    (rhino-stop-process)))

(provide 'rhino-minor-mode)

;;; rhino-minor-mode.el ends here
