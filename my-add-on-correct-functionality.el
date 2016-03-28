
;; TODO make the assignment dynamic!
(defvar obligs-home-directory "~/Downloads/inf1010.2016v.oppg06"
  "A pointer to the directory in which all assignments are downloaded")

(defvar dm-recursion-flag t
  "Set the flag to false in order to break out of the directory recursion")

(defun set-obligs-home-directory (directory)
  (setq obligs-home-directory directory))

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

(defun dm-correct-student (directory)
  "The function called when correcting a student"
  (interactive "Dset the devilry home directory: ")
  (unless default-directory
    (setq default-directory directory))
  (devilry-correct-student directory))



;; Check if directory has .java files, if not. recurse down a dir
;; only check the top buffer, after we've sorted, and excluded .-buffers
(defun devilry-correct-student (directory)
  "Corrects the student associated with directory"
  (unless obligs-home-directory
    (set-obligs-home-directory directory))
  (when dm-recursion-flag
    (unzip-if-zipfile-exists directory)
    (message "The directory passed in is: %s" directory)
    (let ((current-files-and-attributes (directory-files-and-attributes directory t)))
      ;; reverse the list, so that the last delivery is handled first.
      ;; takes advantage of the fact that devilry sorts in descending order,
      ;; so that no internal sorting is required
      (setq current-files-and-attributes (nreverse current-files-and-attributes))
      (dolist (files current-files-and-attributes)
        (let ((dir-path (car files))
              (is-dir (car (cdr files))))
          (message "dir-path %s" dir-path)
          (unless (string= "." (substring dir-path 0 1))
            (when is-dir
              (if (directory-contains-filetype ".java" dir-path)
                  (progn
                   (message "we are in the right dir to correct assignments")
                   (setq dm-recursion-flag nil) ;; break the recursion at all levels
                   (message "The recursion flag %S" dm-recursion-flag)
                   (message "flag above")
                   (open-all-files-in-directory)
                   )
                ;; recurse
                (devilry-correct-student dir-path)
                ))))))))

(message "--------------")

(defun unzip-if-zipfile-exists (dir)
  (let (filename)
    (dolist (dir-files-atts (directory-files-and-attributes dir))
      (setq filename (car dir-files-atts))
      (unless (car (cdr dir-files-atts)) ;; checks if this is a directory
        (when (string= (file-name-extension filename) "zip")
          (call-process-shell-command (format "bash /Users/olepetter/CodeFoo/lisp/projects/devilry-mode/unzip_to_current_folder.bash '%s' '%s'" (concat directory "/" filename) directory)))
  ))))

(defun test-directory-contains-filetype (directory)
  (interactive "Ddir: ")
  (if (directory-contains-filetype ".java" directory)
      (message "Yay!")
    (message "not working!!! grrr")))



;; the command used for getting the proper directory-path
;; consider implementing file-name-sans-extension to check for filetype
(defun directory-contains-filetype (filetype directory)
  (message "directory-contains-filetype")
  (message directory)
  (let (ret-val
        dir-file-name
        is-file-p)
    (dolist (dirfile (directory-files-and-attributes directory) ret-val)
      (message "in ze loop")
      (setq dir-file-name (car dirfile))
      (setq is-file-p (not (car (cdr dirfile))))
      (unless (not is-file-p)
        (when (string= filetype (file-name-extension dir-file-name t))
          (setq ret-val t)
          ))
    )
    ret-val))




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


