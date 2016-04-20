
(defvar py-script-path "initial"
  "The absolute path of the sort-scipt")

(defun set-pyscript-path (directory)
  (interactive "Ddir: ")
  (setq py-script-path directory))

(defun prepare-dir (directory)
  (interactive "Ddir: ")
  (cd directory)
  (call-process-shell-command (concat "python " py-script-path (concat "sort_deliveries.py -b .") ) nil (current-buffer) nil directory))
