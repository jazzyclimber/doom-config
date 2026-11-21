;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
(setq doom-font (font-spec :family "Menlo" :size 16))

;; Open GUI frames at 150 columns x 50 lines
(add-to-list 'default-frame-alist '(width . 150))
(add-to-list 'default-frame-alist '(height . 50))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)
;; Specify both a dark and light theme, like so and Doom will choose which one
;; to load based on your system light/dark setting:
;;
;;   (setq doom-theme '(doom-one   . doom-one-light))   ; (DARK . LIGHT)
;;
;; If you want more pro-active theme switching based on OS light/dark mode, look
;; up the `auto-dark' package.

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Doom's `SPC b' buffer menu only exists in its evil bindings, so recreate it
;; for Meow (evil-only commands swapped for their Emacs equivalents).
(map! :leader
      (:prefix-map ("b" . "buffer")
       :desc "Toggle narrowing"            "-"   #'doom/toggle-narrow-buffer
       :desc "Previous buffer"             "["   #'previous-buffer
       :desc "Next buffer"                 "]"   #'next-buffer
       (:when (modulep! :ui workspaces)
        :desc "Switch workspace buffer" "b" #'persp-switch-to-buffer
        :desc "Switch buffer"           "B" #'switch-to-buffer
        :desc "ibuffer workspace"       "I" #'+ibuffer/open-for-current-workspace)
       (:unless (modulep! :ui workspaces)
        :desc "Switch buffer"           "b" #'switch-to-buffer)
       :desc "Clone buffer"                "c"   #'clone-indirect-buffer
       :desc "Clone buffer other window"   "C"   #'clone-indirect-buffer-other-window
       :desc "Kill buffer"                 "d"   #'kill-current-buffer
       :desc "ibuffer"                     "i"   #'ibuffer
       :desc "Kill buffer"                 "k"   #'kill-current-buffer
       :desc "Kill all buffers"            "K"   #'doom/kill-all-buffers
       :desc "Switch to last buffer"       "l"   #'mode-line-other-buffer
       :desc "Set bookmark"                "m"   #'bookmark-set
       :desc "Delete bookmark"             "M"   #'bookmark-delete
       :desc "Next buffer"                 "n"   #'next-buffer
       :desc "New empty buffer"            "N"   #'+default/new-buffer
       :desc "Kill other buffers"          "O"   #'doom/kill-other-buffers
       :desc "Previous buffer"             "p"   #'previous-buffer
       :desc "Revert buffer"               "r"   #'revert-buffer
       :desc "Rename buffer"               "R"   #'rename-buffer
       :desc "Save buffer"                 "s"   #'basic-save-buffer
       :desc "Save all buffers"            "S"   #'save-some-buffers
       :desc "Save buffer as root"         "u"   #'doom/sudo-save-buffer
       :desc "Pop up scratch buffer"       "x"   #'doom/open-scratch-buffer
       :desc "Switch to scratch buffer"    "X"   #'doom/switch-to-scratch-buffer
       :desc "Yank buffer"                 "y"   #'+default/yank-buffer-contents
       :desc "Bury buffer"                 "z"   #'bury-buffer
       :desc "Kill buried buffers"         "Z"   #'doom/kill-buried-buffers))

;; Put the code, git and workspace menus back where Doom's evil bindings have
;; them. Meow's keypad normally turns `SPC c' into C-c and `SPC g' into C-M-,
;; so free those keys first (C-M- moves to `SPC G').
(after! meow
  (setq meow-keypad-start-keys (assq-delete-all ?c (copy-alist meow-keypad-start-keys))
        meow-keypad-ctrl-meta-prefix ?G))

;; doom-meow moved code to `SPC k' and hung the localleader off C-c c. Put the
;; code map back on `c' and the localleader back on its usual C-c l (`SPC l').
(setq doom-localleader-alt-key "C-c l")
(define-key doom-leader-map "l" nil)
(define-key doom-leader-map "c" (cons "code" doom-leader-code-map))
(define-key doom-leader-map "g" (cons "git" doom-leader-versioning-map))

(map! :leader
      :desc "Jump to bookmark" "RET" #'bookmark-jump
      (:when (modulep! :ui workspaces)
       (:prefix-map ("TAB" . "workspace")
        :desc "Display tab bar"           "TAB" #'+workspace/display
        :desc "Switch workspace"          "."   #'+workspace/switch-to
        :desc "Switch to last workspace"  "`"   #'+workspace/other
        :desc "New workspace"             "n"   #'+workspace/new
        :desc "New named workspace"       "N"   #'+workspace/new-named
        :desc "Load workspace from file"  "l"   #'+workspace/load
        :desc "Save workspace to file"    "s"   #'+workspace/save
        :desc "Kill session"              "x"   #'+workspace/kill-session
        :desc "Kill this workspace"       "d"   #'+workspace/kill
        :desc "Delete saved workspace"    "D"   #'+workspace/delete
        :desc "Rename workspace"          "r"   #'+workspace/rename
        :desc "Restore last session"      "R"   #'+workspace/restore-last-session
        :desc "Next workspace"            "]"   #'+workspace/switch-right
        :desc "Previous workspace"        "["   #'+workspace/switch-left
        :desc "Switch to 1st workspace"   "1"   #'+workspace/switch-to-0
        :desc "Switch to 2nd workspace"   "2"   #'+workspace/switch-to-1
        :desc "Switch to 3rd workspace"   "3"   #'+workspace/switch-to-2
        :desc "Switch to 4th workspace"   "4"   #'+workspace/switch-to-3
        :desc "Switch to 5th workspace"   "5"   #'+workspace/switch-to-4
        :desc "Switch to 6th workspace"   "6"   #'+workspace/switch-to-5
        :desc "Switch to 7th workspace"   "7"   #'+workspace/switch-to-6
        :desc "Switch to 8th workspace"   "8"   #'+workspace/switch-to-7
        :desc "Switch to 9th workspace"   "9"   #'+workspace/switch-to-8
        :desc "Switch to final workspace" "0"   #'+workspace/switch-to-final)))

(defun +my/select-window-right ()
  "Select the window to the right, splitting one off if needed."
  (select-window (or (window-in-direction 'right) (split-window-right))))

(defun +my/bookmark-jump-right ()
  "Jump to a bookmark in the window to the right."
  (interactive)
  (let ((bookmark (bookmark-completing-read "Jump to bookmark (right)")))
    (+my/select-window-right)
    (bookmark-jump bookmark)))

(defun +my/dired-find-file-right ()
  "Open the file at point in the window to the right."
  (interactive)
  (let ((file (dired-get-file-for-visit)))
    (+my/select-window-right)
    (find-file file)))

(map! :leader :desc "Jump to bookmark (right)" "b o" #'+my/bookmark-jump-right)
(map! :after dired :map dired-mode-map "o" #'+my/dired-find-file-right)
(map! :leader :desc "Find file in project" "SPC" #'projectile-find-file)

;; Swap Meow's j/k: j goes up, k goes down.
(after! meow
  (meow-normal-define-key
   '("j" . meow-prev)
   '("J" . meow-prev-expand)
   '("k" . meow-next)
   '("K" . meow-next-expand))
  (meow-motion-overwrite-define-key
   '("j" . previous-line)
   '("k" . next-line)))

;; Use a block cursor outside insert state (doom-meow defaults to a thin bar
;; everywhere); insert state keeps the blinking bar so the two are easy to tell
;; apart.
(after! meow
  (setq meow-cursor-type-normal 'box
        meow-cursor-type-motion 'box
        meow-cursor-type-beacon 'box
        meow-cursor-type-region-cursor 'box))

;; Bright orange cursor (Meow's per-state cursor faces all inherit `cursor').
(custom-set-faces! '(cursor :background "#ff8c00"))

;; `SPC s /' runs a plain isearch (like C-s). When any isearch ends, its string
;; is handed to Meow's search ring, so `n' / `N' then jump to the next/previous
;; match (in dired too).
(defun +my/isearch-to-meow-h ()
  "Push the finished isearch string onto `regexp-search-ring' for `meow-search'."
  (unless (or isearch-mode-end-hook-quit (string-empty-p isearch-string))
    (add-to-history
     'regexp-search-ring
     (if isearch-regexp
         isearch-string
       ;; `meow-search' is case-sensitive, so spell out isearch's case folding.
       (let ((re (regexp-quote isearch-string)))
         (if isearch-case-fold-search
             (replace-regexp-in-string
              "[[:alpha:]]"
              (lambda (c) (format "[%s%s]" (downcase c) (upcase c)))
              re t t)
           re)))
     regexp-search-ring-max)))
(add-hook 'isearch-mode-end-hook #'+my/isearch-to-meow-h)

(defun +my/meow-search-backward ()
  "Select the previous match of the last search."
  (interactive)
  (when (region-active-p)
    (goto-char (region-beginning))
    (deactivate-mark))
  (meow-search -1))

(defun +my/dired-search-next (&optional backward)
  "Move to the next entry matching the last search (previous if BACKWARD)."
  (interactive)
  (let ((re (car regexp-search-ring))
        (start (point))
        (case-fold-search nil))
    (unless re (user-error "No previous search"))
    (if backward (beginning-of-line) (end-of-line))
    (unless (if backward (re-search-backward re nil t) (re-search-forward re nil t))
      (goto-char start)
      (message "No more matches"))))

(defun +my/dired-search-previous ()
  "Move to the previous entry matching the last search."
  (interactive)
  (+my/dired-search-next t))

(map! :leader :desc "Search buffer (isearch)" "s /" #'isearch-forward)
(after! meow
  (meow-normal-define-key '("N" . +my/meow-search-backward)))
(map! :after dired :map dired-mode-map
      "n" #'+my/dired-search-next
      "N" #'+my/dired-search-previous)

(defun +my/window-maximize-90 ()
  "Grow the selected window to ~90% of the frame, leaving the others visible.
If it's already that big, balance all windows instead."
  (interactive)
  (let ((win (selected-window))
        grew)
    (dolist (horizontal '(t nil))
      (let* ((target (floor (* 0.9 (window-total-size (frame-root-window) horizontal))))
             (delta (window-resizable win (- target (window-total-size win horizontal))
                                      horizontal)))
        (when (> delta 0)
          (window-resize win delta horizontal)
          (setq grew t))))
    (unless grew
      (balance-windows))))

;; Doom's emacs bindings put workspaces + sessions on `SPC w'. Workspaces now
;; live on `SPC TAB', so make `SPC w' the window menu evil users get, with j/k
;; swapped to match the Meow swap above (j = up, k = down).
(map! :leader
      (:prefix-map ("w" . "window")
       :desc "Window left"              "h" #'windmove-left
       :desc "Window up"                "j" #'windmove-up
       :desc "Window down"              "k" #'windmove-down
       :desc "Window right"             "l" #'windmove-right
       :desc "Swap window left"         "H" #'windmove-swap-states-left
       :desc "Swap window up"           "J" #'windmove-swap-states-up
       :desc "Swap window down"         "K" #'windmove-swap-states-down
       :desc "Swap window right"        "L" #'windmove-swap-states-right
       :desc "Next window"              "w" #'other-window
       :desc "Previous window"          "W" (cmd! (other-window -1))
       :desc "Split right"              "v" #'split-window-right
       :desc "Split below"              "s" #'split-window-below
       :desc "Split right and follow"   "V" (cmd! (select-window (split-window-right)))
       :desc "Split below and follow"   "S" (cmd! (select-window (split-window-below)))
       :desc "Close window"             "d" #'delete-window
       :desc "Close window"             "c" #'delete-window
       :desc "Close other windows"      "O" #'delete-other-windows
       :desc "Enlarge window"           "o" #'doom/window-enlargen
       :desc "Balance windows"          "=" #'balance-windows
       :desc "Taller"                   "+" #'enlarge-window
       :desc "Shorter"                  "-" #'shrink-window
       :desc "Wider"                    ">" #'enlarge-window-horizontally
       :desc "Narrower"                 "<" #'shrink-window-horizontally
       :desc "Maximize (90%) / balance" "m" #'+my/window-maximize-90
       :desc "Undo window layout"       "u" #'winner-undo
       :desc "Redo window layout"       "U" #'winner-redo
       :desc "Tear off into new frame"  "T" #'tear-off-window))

;; Half-page scrolling in Meow's normal state, following the j/k swap:
;; C-j scrolls up, C-k scrolls down.
(defun +my/scroll-half-page-up ()
  "Scroll up half a window."
  (interactive)
  (scroll-down-command (max 1 (/ (window-body-height) 2))))

(defun +my/scroll-half-page-down ()
  "Scroll down half a window."
  (interactive)
  (scroll-up-command (max 1 (/ (window-body-height) 2))))

(after! meow
  (meow-normal-define-key
   '("C-j" . +my/scroll-half-page-up)
   '("C-k" . +my/scroll-half-page-down)))
(map! :leader :desc "Jump to references" "c r" #'+lookup/references)
