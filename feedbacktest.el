;;"^[+-]\\{3\\}\\(.*\\)$"
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
    (message good-list)
    (message bad-list)
    nil
    ))

;;; new beginning
(defun make-list-recursively-from-regexp (start-pos regexp string)
  "returns a list of the matched substring atoms"
  (let (
        (matched-position (string-match regexp string start-pos)))
    (when (integerp matched-position)
      (cons (substring string start-pos (match-end 0)) (make-good-list-recursively (match-end 0) regexp string)))))


(defun get-input-file-as-string (file-path)
  (interactive "ffile: ")
  (with-temp-buffer
    (insert-file-contents file-path)
    (buffer-string)))
