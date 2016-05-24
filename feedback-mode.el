

(defface positive-feedback
  '((((class color) (min-colors 88) (background light))
     :background "darkseagreen2")
    (((class color) (min-colors 88) (background dark))
     :background "darkolivegreen")
    (((class color) (min-colors 16) (background light))
     :background "darkseagreen2")
    (((class color) (min-colors 16) (background dark))
     :background "darkolivegreen")
    (((class color) (min-colors 8))
     :background "green" :foreground "black")
    (t :inverse-video t))
  "Basic face for highlighting.")



(defface negative-feedback
  '((((class color) (min-colors 88) (background light))
     :background "darkseagreen2")
    (((class color) (min-colors 88) (background dark))
     :background "darkolivegreen")
    (((class color) (min-colors 16) (background light))
     :background "darkseagreen2")
    (((class color) (min-colors 16) (background dark))
     :background "darkolivegreen")
    (((class color) (min-colors 8))
     :background "red" :foreground "black")
    (t :inverse-video t))
  "Basic face for highlighting.")

(defun dm-feedback-init ()
  (interactive)
  (message "Initialize feedback mode")
  (find-file "oblign.feedback")
  (highlight-regexp "^++.*" 'positive-feedback)
  (highlight-regexp "^-+.*" 'negative-feedback))

(defun feedback-add-to-feedback ()
  (interactive)
  (message "Adding to feedback"))

(defun feedback-dismiss-feedback ()
  (interactive)
  (message "Dismissing feedback"))

(define-minor-mode devilry-feedback-mode
  nil
  :lighter "Feedback"
  :global t
  :init-value nil
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "<F5>") 'feedback-add-to-feedback)
            (define-key map (kbd "<F6>") 'feedback-dismiss-feedback)
            map)
  (dm-feedback-init))

(provide 'devilry-feedback-mode)
