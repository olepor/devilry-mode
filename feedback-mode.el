

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

(defun dm-feedback-init
    (message "Initialize feedback mode"))

(defun feedback-add-to-feedback
    (message "Adding to feedback"))

(defun feedback-dismiss-feedback
    (message "Dismissing feedback"))

(define-minor-mode devilry-feedback-mode
  nil
  :lighter "Feedback"
  :global t
  :init-value nil
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "a") 'feedback-add-to-feedback)
            (define-key map (kbd "s") 'feedback-dismiss-feedback)
            map)
  (dm-feedback-init))

(provide 'devilry-feedback-mode)
