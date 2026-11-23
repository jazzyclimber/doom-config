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
  (setq meow-keypad-start-keys (assq-delete-all ?x (assq-delete-all ?c (copy-alist meow-keypad-start-keys)))
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

;; `o' in normal state opens what's at point (an org link) or else a file by
;; name, in the window to the right, like `o' in dired. Meow's block selection
;; moves from `o' to `O' (replacing `meow-to-block').
(defun +my/find-file-right (file)
  "Open FILE in the window to the right."
  (interactive (list (read-file-name "Find file (right): ")))
  (+my/select-window-right)
  (find-file file))

(defun +my/org-open-link-right ()
  "Open the org link at point in the window to the right.
Web and mail links just open normally."
  (let ((type (org-element-property :type (org-element-context)))
        (buf (current-buffer))
        (pos (point)))
    (if (member type '("http" "https" "mailto"))
        (org-open-at-point)
      ;; Show this buffer on the right and follow the link from there, so file
      ;; links and links to headings both land in the right window.
      (+my/select-window-right)
      (switch-to-buffer buf)
      (goto-char pos)
      (let ((org-link-frame-setup (cons '(file . find-file) org-link-frame-setup)))
        (org-open-at-point)))))

(defun +my/open-right ()
  "Open what's at point on the right: an org link, or else a file by name."
  (interactive)
  (if (and (derived-mode-p 'org-mode)
           (eq (org-element-type (org-element-context)) 'link))
      (+my/org-open-link-right)
    (call-interactively #'+my/find-file-right)))

(after! meow
  (meow-normal-define-key
   '("o" . +my/open-right)
   '("O" . meow-block)))

;; In Magit, RET on a changed file or hunk opens it in the window to the right
;; (keeping the status buffer visible) instead of replacing the Magit window.
(defun +my/magit-diff-visit-file-right ()
  "Like `magit-diff-visit-file', but display the file in the window to the right."
  (interactive)
  (magit-diff-visit-file--internal
   (and magit-diff-visit-prefer-worktree
        (memq (magit-diff--dwim) '(staged unstaged)))
   (lambda (buf)
     (+my/select-window-right)
     (switch-to-buffer buf))))

(map! :after magit :map magit-diff-section-map
      [remap magit-visit-thing] #'+my/magit-diff-visit-file-right)

;; `SPC a' / `SPC k' run whatever C-c C-c (accept/confirm) and C-c C-k
;; (kill/cancel) do in the current buffer, e.g. finishing or aborting a commit
;; message. `SPC k' was doom-meow's duplicate of the code menu, now on `SPC c'.
(defun +my/run-key-here (keys)
  "Run the command bound to KEYS in the current buffer."
  (let ((cmd (key-binding (kbd keys))))
    (if (commandp cmd)
        (call-interactively cmd)
      (user-error "%s does nothing here" keys))))

(defun +my/confirm ()
  "Confirm/finish, like C-c C-c."
  (interactive)
  (+my/run-key-here "C-c C-c"))

(defun +my/cancel ()
  "Cancel/abort, like C-c C-k."
  (interactive)
  (+my/run-key-here "C-c C-k"))

(map! :leader
      :desc "Confirm (C-c C-c)" "a" #'+my/confirm
      :desc "Cancel (C-c C-k)"  "k" #'+my/cancel)

;; Ctrl+Backspace deletes the word before point (default); Alt+Backspace now
;; deletes the word after it.
(map! "M-DEL"         #'kill-word
      [M-backspace]   #'kill-word)

;; Per-repo notes: `SPC x' captures into ~/org/projects/<repo>.org under "Notes".
(defvar +my/org-capture-project nil
  "Project name chosen for the capture in progress.")

(defun +my/org-project-file ()
  "File for the project chosen by `+my/org-capture-project'."
  (let ((dir (expand-file-name "projects/" org-directory)))
    (make-directory dir t)
    (expand-file-name (concat +my/org-capture-project ".org") dir)))

(defun +my/org-project-notes-heading ()
  "Move to the \"Notes\" heading of the project file, creating it if needed."
  (goto-char (point-min))
  (unless (re-search-forward "^\\* Notes\\b" nil t)
    (when (= (buffer-size) 0)
      (insert "#+title: " +my/org-capture-project "\n\n"))
    (goto-char (point-max))
    (unless (bolp) (insert "\n"))
    (insert "* Notes\n")
    (forward-line -1))
  (beginning-of-line))

(defun +my/org-capture-project ()
  "Capture a note into the current project's Org file.
Outside a project, ask which project file to use."
  (interactive)
  (setq +my/org-capture-project
        (or (and (fboundp 'projectile-project-p) (projectile-project-p)
                 (projectile-project-name))
            (completing-read
             "Project: "
             (mapcar #'file-name-base
                     (directory-files (expand-file-name "projects/" org-directory)
                                      nil "\\.org\\'")))))
  (org-capture nil "p"))

(after! org-capture
  (add-to-list 'org-capture-templates
               '("p" "Project note" entry
                 (file+function +my/org-project-file +my/org-project-notes-heading)
                 "* %?\n  %U\n  %a\n")))

;; Capture into any Org file under `org-directory', under a heading you pick.
(defvar +my/org-capture-file nil "File chosen for the capture in progress.")
(defvar +my/org-capture-line nil
  "Line of the heading to file under, or nil to append at the top level.")

(defun +my/org-capture-target-file () +my/org-capture-file)

(defun +my/org-capture-target-heading ()
  "Move point to the chosen heading, or to the end of the file."
  (widen)
  (if +my/org-capture-line
      (progn (goto-char (point-min))
             (forward-line (1- +my/org-capture-line)))
    (goto-char (point-max))
    (unless (or (bobp) (bolp)) (insert "\n"))))

(defun +my/org-file-headings (file)
  "Return an alist of (LABEL . LINE) for the headings in FILE."
  (when (file-exists-p file)
    (with-current-buffer (find-file-noselect file)
      (save-excursion
        (save-restriction
          (widen)
          (goto-char (point-min))
          (let (res)
            (while (re-search-forward "^\\(\\*+\\) \\(.*\\)$" nil t)
              (push (cons (concat (make-string (* 2 (1- (length (match-string 1)))) ?\s)
                                  (match-string 1) " " (match-string 2))
                          (line-number-at-pos (match-beginning 0)))
                    res))
            (nreverse res)))))))

(defun +my/org-capture-in-file ()
  "Capture a note into an Org file you pick, under a heading you pick."
  (interactive)
  (let* ((dir (file-name-as-directory (expand-file-name org-directory)))
         (rels (mapcar (lambda (f) (file-relative-name f dir))
                       (directory-files-recursively dir "\\.org\\'")))
         (rel (completing-read "Org file (new name to create): " rels))
         (file (expand-file-name (if (string-suffix-p ".org" rel) rel (concat rel ".org")) dir))
         (headings (+my/org-file-headings file))
         (top "(top level, end of file)")
         (choice (completing-read
                  "File under: "
                  (lambda (str pred action)
                    (if (eq action 'metadata)
                        '(metadata (display-sort-function . identity))
                      (complete-with-action action (cons top (mapcar #'car headings)) str pred)))
                  nil t)))
    (make-directory (file-name-directory file) t)
    (setq +my/org-capture-file file
          +my/org-capture-line (cdr (assoc choice headings)))
    (org-capture nil "f")))

(after! org-capture
  (add-to-list 'org-capture-templates
               '("f" "Note in chosen file" entry
                 (file+function +my/org-capture-target-file +my/org-capture-target-heading)
                 "* %?\n  %U\n  %a\n")))

(map! :leader
      :desc "Project note"  "x" #'+my/org-capture-project
      (:prefix-map ("X" . "capture")
       :desc "Note in chosen file"  "f" #'+my/org-capture-in-file
       :desc "Org capture menu"     "X" #'org-capture))

;; Run/build menu on `SPC r': package.json scripts and arbitrary build commands
;; run in an async shell buffer at the project (or package) root.
(defvar +my/js-script-prefix "bend yarn"
  "Command prefix used to run package.json scripts.")

(defvar +my/run-history nil "History of commands run from `SPC r c'.")
(defvar +my/run-last nil "Last run as (COMMAND DIRECTORY BUFFER-NAME).")

(defun +my/run-in (command dir)
  "Run COMMAND in DIR in an async shell buffer and remember it."
  (let ((buf (format "*run: %s*" command))
        (default-directory dir))
    (setq +my/run-last (list command dir buf))
    (async-shell-command command buf)))

(defun +my/project-root ()
  (or (and (fboundp 'projectile-project-root) (projectile-project-root))
      default-directory))

(defun +my/package-json-files ()
  "Return package.json files from here up to the project root, nearest first."
  (let* ((stop (and (fboundp 'projectile-project-root)
                    (projectile-project-root)))
         (stop (and stop (file-truename stop)))
         (dir (file-truename default-directory))
         (home (file-truename "~/"))
         files)
    (while dir
      (let ((file (expand-file-name "package.json" dir)))
        (when (file-exists-p file) (push file files)))
      (setq dir (and (not (equal dir stop))
                     (not (equal dir home))
                     (let ((parent (file-name-directory (directory-file-name dir))))
                       (and (not (equal parent dir)) parent)))))
    (nreverse files)))

(defun +my/package-json-read (file)
  "Return (LABEL . SCRIPTS-ALIST) for package.json FILE."
  (with-temp-buffer
    (insert-file-contents file)
    (let* ((json (json-parse-buffer))
           (scripts (gethash "scripts" json))
           (rel (abbreviate-file-name (file-name-directory file)))
           (label (format "%s  (%s)" (or (gethash "name" json) "unnamed") rel)))
      (cons label
            (and scripts
                 (mapcar (lambda (k) (cons k (gethash k scripts)))
                         (sort (hash-table-keys scripts) #'string<)))))))

(defun +my/run-package-script (&optional ask-prefix)
  "Pick a script from every package.json up to the project root and run it.
Scripts are grouped by package.json, nearest first.  With a prefix
argument, ask for the command prefix first."
  (interactive "P")
  (let ((files (or (+my/package-json-files) (user-error "No package.json found")))
        (table (make-hash-table :test 'equal))
        cands)
    (dolist (file files)
      (let ((read (+my/package-json-read file)))
        (dolist (s (cdr read))
          (let ((cand (propertize (format "%s  [%s]" (car s) (car read))
                                  'my-label (car read) 'my-cmd (cdr s))))
            (puthash cand (cons (car s) (file-name-directory file)) table)
            (push cand cands)))))
    (unless cands (user-error "No scripts in any package.json"))
    (setq cands (nreverse cands))
    (let* ((choice
            (completing-read
             "Script: "
             (lambda (str pred action)
               (if (eq action 'metadata)
                   `(metadata
                     (display-sort-function . identity)
                     (cycle-sort-function . identity)
                     (group-function
                      . ,(lambda (c transform)
                           (let ((label (get-text-property 0 'my-label c)))
                             (if transform
                                 (substring c 0 (- (length c) (length label) 4))
                               label))))
                     (annotation-function
                      . ,(lambda (c)
                           (let ((cmd (get-text-property 0 'my-cmd c)))
                             (and cmd (concat "  " (truncate-string-to-width cmd 60 nil nil "…")))))))
                 (complete-with-action action cands str pred)))
             nil t))
           (hit (gethash choice table)))
      (when ask-prefix (+my/set-script-prefix))
      (+my/run-in (concat +my/js-script-prefix " " (car hit)) (cdr hit)))))

(defun +my/set-script-prefix ()
  "Change the command prefix used for package.json scripts."
  (interactive)
  (setq +my/js-script-prefix
        (read-string "Script prefix: " +my/js-script-prefix))
  (message "Script prefix: %s" +my/js-script-prefix))

(defun +my/run-build-command (&optional here)
  "Run any build command in the project root, with history.
With a prefix argument, run it in the current directory instead."
  (interactive "P")
  (let ((root (if here default-directory (+my/project-root))))
    (+my/run-in (read-shell-command (format "Run in %s: " (abbreviate-file-name root))
                                    (car +my/run-history) '+my/run-history)
                root)))

(defun +my/run-again ()
  "Run the last command again."
  (interactive)
  (unless +my/run-last (user-error "Nothing has been run yet"))
  (+my/run-in (nth 0 +my/run-last) (nth 1 +my/run-last)))

(defun +my/run-last-buffer ()
  "Show the buffer of the last run."
  (interactive)
  (let ((buf (and +my/run-last (get-buffer (nth 2 +my/run-last)))))
    (if buf (pop-to-buffer buf) (user-error "No run buffer"))))

(defun +my/run-kill ()
  "Stop the last run's process."
  (interactive)
  (let* ((buf (and +my/run-last (get-buffer (nth 2 +my/run-last))))
         (proc (and buf (get-buffer-process buf))))
    (if (process-live-p proc)
        (progn (interrupt-process proc) (message "Stopped: %s" (nth 0 +my/run-last)))
      (message "Nothing running"))))

(map! :leader
      (:prefix-map ("r" . "run/build")
       :desc "Package.json script"   "s" #'+my/run-package-script
       :desc "Run build command"     "c" #'+my/run-build-command
       :desc "Run last again"        "r" #'+my/run-again
       :desc "Last run buffer"       "b" #'+my/run-last-buffer
       :desc "Stop running process"  "k" #'+my/run-kill
       :desc "Set script prefix"     "p" #'+my/set-script-prefix))

;; Save and return to a cursor position without making a bookmark.
;; `SPC j m' remembers the position, `SPC j j' jumps back to it.
;; With C-u, either key asks for a register letter so you can keep several.
(defun +my/pin-register (arg)
  (if arg (read-char "Register: ") ?p))

(defun +my/pin-set (arg)
  "Remember the cursor position (in register p, or one you choose with C-u)."
  (interactive "P")
  (let ((reg (+my/pin-register arg)))
    (point-to-register reg)
    (message "Position saved in register %c" reg)))

(defun +my/pin-jump (arg)
  "Jump back to the remembered cursor position."
  (interactive "P")
  (let ((reg (+my/pin-register arg)))
    (unless (get-register reg) (user-error "Nothing saved in register %c" reg))
    (push-mark nil t)
    (jump-to-register reg)))

(map! :leader
      (:prefix-map ("j" . "jump")
       :desc "Save position"       "m" #'+my/pin-set
       :desc "Jump back to saved"  "j" #'+my/pin-jump))

;; JSX/TSX outline: `SPC j t' lists components and JSX tags as an indented
;; tree (names only, no props); picking one jumps to it, with live preview.
(defun +my/jsx-parser ()
  "Return a tree-sitter parser that understands JSX for this buffer."
  (or (cl-find-if (lambda (p) (memq (treesit-parser-language p) '(tsx javascript jsx)))
                  (treesit-parser-list))
      (cl-some (lambda (lang)
                 (and (treesit-language-available-p lang)
                      (treesit-parser-create lang)))
               '(tsx javascript))
      (user-error "No tree-sitter grammar for JSX/TSX is available")))

(defun +my/jsx-outline-candidates ()
  "Return outline entries as a list of (LABEL . POSITION) in buffer order."
  (let* ((root (treesit-parser-root-node (+my/jsx-parser)))
         (fn-types '("arrow_function" "function_expression" "function"))
         res)
    (cl-labels
        ((text (n) (and n (treesit-node-text n t)))
         (add (depth label node)
           (push (cons (format "%s%s  L%d"
                               (make-string (* 2 depth) ?\s) label
                               (line-number-at-pos (treesit-node-start node)))
                       (treesit-node-start node))
                 res))
         (component-p (node)
           (let ((name (text (treesit-node-child-by-field-name node "name")))
                 (val (treesit-node-child-by-field-name node "value")))
             (and name val
                  (or (member (treesit-node-type val) fn-types)
                      (and (equal (treesit-node-type val) "call_expression")
                           (let ((case-fold-search nil)) (string-match-p "\\`[A-Z]" name)))))))
         (walk (node depth)
           (let ((type (treesit-node-type node)) (d depth))
             (cond
              ((member type '("function_declaration" "class_declaration"
                              "generator_function_declaration"))
               (when-let* ((name (text (treesit-node-child-by-field-name node "name"))))
                 (add depth (concat (if (equal type "class_declaration") "class " "ƒ ") name) node)
                 (setq d (1+ depth))))
              ((and (equal type "variable_declarator") (component-p node))
               (add depth (concat "ƒ " (text (treesit-node-child-by-field-name node "name"))) node)
               (setq d (1+ depth)))
              ((equal type "jsx_self_closing_element")
               (add depth (format "<%s>" (or (text (treesit-node-child-by-field-name node "name")) "")) node))
              ((equal type "jsx_element")
               (let* ((open (treesit-node-child-by-field-name node "open_tag"))
                      (name (text (and open (treesit-node-child-by-field-name open "name")))))
                 (add depth (format "<%s>" (or name "")) node)
                 (setq d (1+ depth)))))
             (dolist (c (treesit-node-children node t))
               (walk c d)))))
      (walk root 0))
    (nreverse res)))

(defun +my/jsx-outline ()
  "Pick a component or JSX tag from an indented outline and jump to it."
  (interactive)
  (require 'consult)
  (let* ((entries (or (+my/jsx-outline-candidates) (user-error "No components or JSX tags found")))
         (cands (mapcar (lambda (e)
                          (propertize (car e) 'consult--candidate
                                      (copy-marker (cdr e))))
                        entries)))
    (consult--read cands
                   :prompt "JSX outline: "
                   :sort nil
                   :require-match t
                   :category 'jsx-outline
                   :lookup #'consult--lookup-candidate
                   :state (consult--jump-state))))

(map! :leader :desc "JSX/TSX outline" "j t" #'+my/jsx-outline)

;; Git permalink: `SPC g y' copies a commit-pinned GitHub link to the selection,
;; or to the current line when nothing is selected.
(defun +my/git-permalink ()
  "Copy a permalink (commit hash, not branch) to the selection or current line."
  (interactive)
  (require 'git-link)
  (let ((git-link-use-commit t)
        (git-link-open-in-browser nil))
    (apply #'git-link (git-link--remote)
           (if (use-region-p)
               (git-link--get-region)
             (list (line-number-at-pos) nil)))))

(map! :leader :desc "Copy git permalink" "g y" #'+my/git-permalink)
