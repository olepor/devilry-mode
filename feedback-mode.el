(defun dm-feedback-init ()
  (interactive)
  (message "Initialize feedback mode")
  (find-file "oblign.feedback")
  (highlight-regexp "^++.*" 'highlight)
  (highlight-regexp "^-+.*" 'highlight))

(defun feedback-add-to-feedback ()
  (interactive)
  (message "Adding to feedback"))

(defun feedback-dismiss-feedback ()
  (interactive)
  (message "Dismissing feedback"))

;; (define-minor-mode devilry-feedback-mode
;;   nil
;;   :lighter "Feedback"
;;   :global t
;;   :init-value nil
;;   :keymap (let ((map (make-sparse-keymap)))
;;             (define-key map (kbd "<F5>") 'feedback-add-to-feedback)
;;             (define-key map (kbd "<F6>") 'feedback-dismiss-feedback)
;;             map)
;;   (dm-feedback-init))

(setq my-feedback-highlights
      '(("^++.*" . highlight)
        ("^-+.*" . font-lock-keyword-face)))

(defvar devilry-feedback-mode-hook nil)

(defvar devilry-feedback-map
  (let ((map (make-keymap)))
    (define-key map "<f5>" 'feedback-add-to-feedback)
    map)
  "Keymap for devilry-feedback-mode")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.feedback\\'" . devilry-feedback-mode))

(defvar sample-font-lock-keywords
  `((,"^++.*" . highlight)
    ("^-+.*" . highlight))
  "Keyword highlighting specification for `devilry-feedback-mode'.")


(defconst my-devilry-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; ' is a string delimiter
    (modify-syntax-entry ?' "\"" table)
    ;; " is a string delimiter too
    (modify-syntax-entry ?\" "\"" table)

    ;; / is punctuation, but // is a comment starter
    (modify-syntax-entry ?/ ". 12" table)
    ;; \n is a comment ender
    (modify-syntax-entry ?\n ">" table)
    table))

(make-face 'font-lock-devilry-feedback-face)
(set-face-foreground 'font-lock-devilry-feedback-face "pink")
(set-face-background 'font-lock-devilry-feedback-face "blue")

(defvar devilry-feedback-mode-keyword-test
  '(("solid" . highlight)
    ("^+\\{3\\}\\(.*\\)$" . highlight)
    ("effort" . highlight))
  "Test for the highligting syntax")

(defun feedback-test-keymap ()
  (message "Hello there"))

;;;###autoload
(define-derived-mode devilry-feedback-mode nil "Devilry-feedback"
  "A simple major mode which helps automating student feedback
\\{devilry-feedback-mode-map}"
  ;; :syntax-table my-devilry-mode-syntax-table
  ;; (setq-local font-lock-keywords
  ;;             '((sample-font-lock-keywords)))
  ;; (use-local-map devilry-feedback-map)
  (message "Activated")
  ;; (highlight-regexp "^++.*" 'negative-feedback-face)
  ;; (setq-local font-lock-defaults '(devilry-feedback-mode-keyword-test))
  :lighter "Dev-Feed"
  :global t
  :init-value nil
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "<f5>") 'f-insert-to-feedback-file)
            (message "defining keys for keymap")
            map)
  )


(provide 'devilry-feedback-mode)



