
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
  (unzip-if-zipfile-exists directory)
  (interactive "DDirectory to correct:")
  (message "The directory passed in is: %s" directory)
  (let ((current-files-and-attributes (directory-files-and-attributes directory t)))
    ;; reverse the list, so that the last delivery is handled first.
    ;; takes advantage of the fact that devilry sorts in descending order,
    ;; so that no internal sorting is required
    (setq current-files-and-attributes (nreverse current-files-and-attributes))
    (dolist (files current-files-and-attributes)
      (let ((dir-path (car files))
            (is-dir (car (cdr files))))
            (unless (string= "." (substring dir-path 0 1))
              (if (directory-contains-filetype ".java" dir-path)
                  (cond
                   (t (message "we are in the right dir to correct assignments"))
                   (t (open-all-files-in-directory))
                   )
                (when is-dir
                  ;; recurse
                  (devilry-correct-student dir-path)
            )))))))

(defun unzip-if-zipfile-exists (dir)
  (let (filename
        is-dir)
    (dolist (dir-files-atts (directory-files-and-attributes dir))
      (setq filename (car dir-files-atts))
      (setq (is-dir (car (cdr dir-files-atts))))
      (unless is-dir
        (when (string= (file-name-extension filename) "zip")
          (call-process-shell-command (format "bash /Users/olepetter/CodeFoo/lisp/projects/devilry-mode/unzip_to_current_folder.bash '%s' '%s'" (concat directory "/" dir-file-name) directory)))
  ))))

;; the command used for getting the proper directory-path
;; consider implementing file-name-sans-extension to check for filetype
(defun directory-contains-filetype (filetype directory)
  (message "directory-contains-filetype")
  (message directory)
  (message "after dir pritn")
  (let (ret-val
        dir-file-name
        is-file-p)
    (dolist (dir/file (directory-files-and-attributes directory) ret-val)
      (message "in ze loop")
      (setq dir-file-name (car dir/file))
      (setq is-file-p (car (cdr dir/file)))
      (unless (string= "." (substring dir-file-name 0 1))
        (when (string= filetype (file-name-extension dir-file-name))
          (setq ret-val t))
        ))
    )
  )




(get-buffer-create "*Test*")
(call-process-shell-command "bash unzip_to_current_folder.bash /Users/olepetter/CodeFoo/lisp/projects/devilry-mode/test.zip" nil (get-buffer-create "*test") t)

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

(shell-command "unzip test.zip")
(shell-command "cd ~/Downloads")


