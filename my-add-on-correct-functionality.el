
;; TODO use the directory-files-and-attributes function to
;; see if we're really working with a directory, or a file :)
(defun devilry-do-all-obligs(directory)
  (interactive "DDirectory name: ")
  (let ((current-dir-list (directory-files directory t)))
    (dolist (dir current-dir-list)
      (message dir)
      (unless (equal "." (substring dir -1)) ;; no . directories
        (devilry-correct-student dir)
        )
      )))


;; Check if directory has .java files, if not. recurse down a dir
;; only check the top buffer, after we've sorted, and excluded .-buffers
(defun devilry-correct-student (directory)
  (message "The directory passed in is: %s" directory)
  (let ((current-files-and-attributes (directory-files-and-attributes directory t)))
    ;; reverse the list, so that the last delivery is handled first.
    ;; takes advantage of the fact that devilry sorts in descending order,
    ;; so that no internal sorting is required
    (setq current-files-and-attributes (nreverse current-files-and-attributes))
    (message (car (car current-files-and-attributes)))
    (while (equal "." (substring (car (car current-files-and-attributes))-1))
      (setq current-files-and-attributes (cdr current-files-and-attributes)))
    (message (car (car current-files-and-attributes)))
    ;; Now at the first non . file. Check if it's a dir
    (if (directory-contains-filetype ".java" (car (car current-files-and-attributes)))
        (message "We are in the correct directory to correct the assignments!")
      (message "there are no assignments here, we should move on deeper!")
      (devilry-correct-student (car (car current-files-and-attributes)))
      )))


(defun directory-contains-filetype (filetype directory)
  (message "directory-contains-filetype")
  (dolist (dir (directory-files directory) ret-val)
    (message (concat "$" filetype))
    (when (string-match-p (concat filetype "$") dir)
      (message "Found a %s filetype!" filetype)
      (setq ret-val t))
    )
  ret-val)


