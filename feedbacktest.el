
(defun print-good/bad-lists (input-file)
  (interactive "ffile: ")
  (let (
        (tmp-list (parse-input-to-lists input-file)))
    (message "%d" (length tmp-list))
    (message "%d" (length (car tmp-list)))
    (message "%d" (length (car (cdr tmp-list))))
    (dolist (inner-list tmp-list)
      (dolist (text-object inner-list)
        (message text-object)))))


(defun parse-input-to-lists (input-file)
  (interactive "ffile: ")
  (let (
        (point-start (point))
        (point-end )
        (good-list)
        (bad-list)
        (input-string (get-input-file-as-string input-file)))
    (setq good-list (make-list-recursively-from-regexp 0
                                                "^+\\{3\\}\\(.*\\)$"
                                                input-string))
    (setq bad-list (make-list-recursively-from-regexp 0
                                                      "^-\\{3\\}\\(.*\\)$"
                                                      input-string))
    (list good-list bad-list)
    ))

;;; new beginning
(defun make-list-recursively-from-regexp (start-pos regexp string)
  "returns a list of the matched substring atoms"
  (let (
        (matched-position (string-match regexp string start-pos)))
    (when (integerp matched-position)
      (message (substring string start-pos (match-end 0)))
      (cons (substring string start-pos matched-position) (make-good-list-recursively matched-position regexp string)))))


(defun get-input-file-as-string (file-path)
  (interactive "ffile: ")
  (with-temp-buffer
    (insert-file-contents file-path)
    (buffer-string)))
