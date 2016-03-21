
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
  "Corrects the student associated with directory"
  (interactive "DDirectory to correct:")
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
        (cond
         (t (message "in the right directory to correct files"))
         (t (open-all-files-in-directory))
         )
      (message "there are no assignments here, we should move on deeper!")
      (devilry-correct-student (car (car current-files-and-attributes)))
      )))


;; consider implementing file-name-sans-extension to check for filetype
(defun directory-contains-filetype (filetype directory)
  (message "directory-contains-filetype")
  (let (ret-val
        dir-file-name
        is-file-p)
    (dolist (dir/file (directory-files-and-attributes directory) ret-val)
      (message "in ze loop")
      (setq dir-file-name (car dir/file))
      (setq is-file-p (car (cdr dir/file)))
      (unless (string= "." (substring dir-file-name 0 1))
        (when (string= "zip" (file-name-extension dir-file-name))
          (message "we should now unzip")
          )
        (when (string= filetype (file-name-extension dir-file-name))
          (setq ret-val t))
        )
      )
    )
  )

(message "-------")

(defun open-all-files-in-directory()
  "Opens all files in current directory "
  (let ((dir-files (directory-files-and-attributes ".")))
    (dolist (f dir-files)
      (message (substring (car f) 0 1))
      (unless (eq "." (substring (car f) 0 1))
        (unless (car (cdr f))
          (message (car f))
          (find-file (car f))))))
   )

(open-all-files-in-directory)


