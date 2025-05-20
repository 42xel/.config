;; Keyboard shortcuts
'(define-configuration (input-buffer)
  ((default-modes (pushnew 'nyxt/mode/vi:vi-normal-mode %slot-default%))))

;; Theme & Style
(define-configuration browser
  ((theme theme:+dark-theme+)))

(define-configuration (web-buffer)
  ((default-modes (pushnew 'nyxt/mode/style:dark-mode %slot-default%))))

;; Buffer settings
(defmethod customize-instance ((browser browser) &key)
  (setf (slot-value browser 'default-new-buffer-url) "https://duckduckgo.com/"))

;; Privacy & Security Modes
'(define-configuration (web-buffer)
  ((default-modes (pushnew 'nyxt/mode/blocker:blocker-mode %slot-default%))))

'(define-configuration (web-buffer)
  ((default-modes (pushnew 'nyxt/mode/no-script:no-script-mode %slot-default%))))

(define-configuration (web-buffer)
  ((default-modes
    (pushnew 'nyxt/mode/reduce-tracking:reduce-tracking-mode %slot-default%))))

;; Search engine
(defvar *my-search-engines*
  '(("google" "https://google.com/search?q=~a" "https://google.com")
    ("duckduckgo" "https://duckduckgo.com/?q=~a" "https://duckduckgo.com"))
  "list of search engines")

;; Replaces the default (atlas.engineer) because it is broken.
(define-configuration context-buffer
    ((search-engines
      (append %slot-default%
	      (mapcar (lambda (engine) (apply 'make-search-engine engine))
		      *my-search-engines*)))))
