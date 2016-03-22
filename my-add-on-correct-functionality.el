
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
      (when (car (cdr (car current-files-and-attributes)))
        (message "--- this is a proper directory")
        (devilry-correct-student (car (car current-files-and-attributes))))
      )))

;; pwd | sed 's/ /\\ \\/g                                               '| sed 's/\=/\\=/' | sed 's/)/\\)/g'
;; final command
;; pwd | sed 's/ /\\ \\/g
;;'| sed 's/\=/\\=/' | sed 's/)/\\)/g' | cd; unzip *.zip -d .
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
        (when (string= "zip" (file-name-extension dir-file-name))
          (message "we should now unzip")
          (let (dm-shellcommand)
            (setq dm-shellcommand (format "bash /Users/olepetter/CodeFoo/lisp/projects/devilry-mode/unzip_to_current_folder.bash '%s' '%s'" (concat directory "/" dir-file-name) directory))
            (message "The shell command -----")
            (message dm-shellcommand)
          (message "---- finished the shell command")
          (call-process-shell-command dm-shellcommand nil (current-buffer) t)
          (when (string= filetype (file-name-extension dir-file-name))
          (setq ret-val t))
        ))
        )
      )
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


