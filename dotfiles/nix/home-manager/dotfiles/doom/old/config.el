;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; You do not need to run 'doom sync' after modifying this file!

(setenv "DICTIONARY" "en_CA")
(setenv "LANG" "en")
(global-display-fill-column-indicator-mode)

;;; setq!
(setq! user-full-name "Álan Crístoffer e Sousa"
       user-mail-address "acristoffers@startmail.com"
       doom-font (font-spec :family "JetBrainsMono Nerd Font Mono" :size 12.0)
       doom-unicode-font (font-spec :family "JetBrainsMono Nerd Font Mono")
       doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font")
       doom-theme 'doom-dracula
       confirm-kill-emacs nil
       org-directory (expand-file-name "~/.org/")
       display-line-numbers-type 'visual
       edit-server-new-frame nil
       appt-disp-window-function (function appt-display)
       appt-time-msg-list nil                ;; clear existing appt list
       appt-display-interval 15              ;; warn every 15 minutes
       appt-message-warning-time 60          ;; send first warning 60 minutes before appointment
       appt-display-mode-line nil            ;; don't show in the modeline
       appt-display-format 'window           ;; pass warnings to the designated window function
       comp-async-report-warnings-errors nil ;; Silences elisp JIT compiler
       evil-kill-on-visual-paste nil         ;; Prevents yanking selected text after pasting over it.
       +format-on-save-enabled-modes
       '(not emacs-lisp-mode                 ;; elisp's mechanisms are good enough
         sql-mode                            ;; sqlformat is currently broken
         tex-mode                            ;; latexindent is broken
         typescript-mode
         typescript-tsx-mode
         latex-mode)
       company-tooltip-align-annotations t                           ;; aligns annotation to the right hand side
       lsp-pyright-python-executable-cmd (executable-find "python3") ;; tells pyright what is the right python executable
       ;; Julia LSP config
       ;; In Julia, run
       ;; ] add https://github.com/julia-vscode/LanguageServer.jl
       lsp-julia-default-environment (expand-file-name "~/.julia/environments/v1.8" )
       lsp-julia-package-dir nil
       lsp-enable-folding t
       lsp-folding-range-limit 100
       org-journal-dir (expand-file-name "~/.org/journal")
       org-journal-date-prefix "#+TITLE: "
       org-journal-time-prefix "* "
       org-journal-date-format "%a, %Y-%m-%d"
       org-journal-file-format "%Y-%m-%d.org"
       TeX-output-dir "build"
       org-superstar-headline-bullets-list '("●" "◉" "○" "◆" "✸" "✚" "✜")
       ein:output-area-inlined-images t
       org-pretty-table-mode nil
       langtool-language-tool-jar (expand-file-name "~/.bin/languagetool/5.5/libexec/languagetool-commandline.jar")
       langtool-java-bin (executable-find "java")
       langtool-disabled-rules '("ST_04_001[0]" "ST_04_001[1]" "ST_04_001[2]" "ST_04_001[3]" "ST_04_001[4]" "ST_04_001[5]"
                                 "ST_04_001[6]" "ST_04_001[7]" "ST_04_001[8]" "ST_04_001[9]" "ST_04_001[10]")
       dap-cpptools-extension-version "1.10.8"
       auto-hscroll-mode 't
       hscroll-margin 0
       hscroll-step 1
       projectile-auto-discover t
       pretty-symbols-active nil
       mu4e-maildir (expand-file-name "~/.local/share/mail")
       projectile-project-search-path '("~/.org"
                                        ("~/Developer" . 2)
                                        ("~/Documents/Dropbox/Universidade/Doutorado/Presentations" . 1)
                                        ("~/Documents/Dropbox/Universidade/Doutorado/Code" . 1)
                                        ("~/Documents/Dropbox/Universidade/Doutorado/Articles" . 1)))

;;; use-package!

(use-package! python-black :demand t :after python :config
              (add-hook! 'python-mode-hook #'python-black-on-save-mode)
              (map! :map python-mode-map :leader :desc "Blacken Buffer"    "m b b" #'python-black-buffer)
              (map! :map python-mode-map :leader :desc "Blacken Region"    "m b r" #'python-black-region)
              (map! :map python-mode-map :leader :desc "Blacken Statement" "m b s" #'python-black-statement))
                                        ; (use-package! edit-server :defer t)
                                        ; (use-package! julia-formatter :mode "julia-mode")
(use-package! zig-mode :defer t
              :hook ((zig-mode . lsp-deferred))
              :custom (zig-format-on-save nil))
(use-package! matlab-mode :defer t)
(use-package! appt :defer t)
                                        ; (use-package! evil-text-object-python :defer t)
(use-package! alert
  :custom (alert-default-style (if IS-MAC 'osx-notifier 'notifications))
  :defer t)
(use-package! evil-matchit
  :config (global-evil-matchit-mode 1))
(use-package! tree-sitter
  :config
  (require 'tree-sitter-langs)
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
(use-package! fzf)
(use-package! zoxide)
                                        ; (use-package! atomic-chrome)

;;; add-hook!

;; (add-hook! 'python-mode-hook #'evil-text-object-python-add-bindings)
(add-hook! 'before-save-hook #'tide-format-before-save)
(add-hook! 'text-mode-hook #'auto-fill-mode)
(add-hook! 'matlab-mode-hook
           #'display-line-numbers-mode
           ;; #'matlab-toggle-show-mlint-warnings
           (setq! matlab-file-font-lock-keywords '())
           (rainbow-delimiters-mode-enable)
           (tree-sitter-hl-mode 1)
           (lsp-mode 1)
           (lsp-semantic-tokens-mode 1))
(add-hook! 'julia-mode-hook (add-hook 'before-save-hook
                                      (lambda ()
                                        (julia-formatter-format-region
                                         (point-min)
                                         (point-max)))
                                      nil
                                      t))
(add-hook! 'TeX-mode-hook
  (prettify-symbols-mode)
  (setq! TeX-electric-math (cons "\\(" ""))
  (setq! TeX-quote-after-quote t)
  (sp-with-modes '(tex-mode
                   plain-tex-mode
                   latex-mode
                   LaTeX-mode)
    (sp-local-pair "``" nil
                   :actions :rem)))
(add-hook! 'typescript-mode-hook
  (setup-tide-mode)
  (setq! typescript-indent-level 2))
(add-hook! 'centaur-tabs-mode-hook #'centaur-tabs-group-by-projectile-project)
(add-hook! 'evil-surround-mode-hook
  (add-to-list 'evil-embrace-evil-surround-keys ?,))
(add-hook! 'org-finalize-agenda-hook #'agenda-to-appt) ;; update appt list on agenda view
(add-hook! 'org-pretty-table-mode-hook
  (when org-pretty-table-mode
    (org-pretty-table-mode -1)))
(add-hook! 'after-save-hook
  (when (-contains? (mapcar 'expand-file-name org-agenda-files) (buffer-file-name))
    (agenda-to-appt)))
(add-hook! 'LaTeX-mode-hook
  (dotimes (_ 3)
    (progn (setq! tex-fontify-script nil)
           (setq! font-latex-fontify-script nil)
           (prettify-symbols-mode 0)
           (font-lock-mode 0)
           (font-lock-mode 1))))
(add-hook! 'flyspell-mode-hook
  (when (and (not (boundp 'flyspell-already-ran)) (eq major-mode 'org-mode))
    (setq-local flyspell-already-ran t)
    (flyspell-mode-off)))

;;; after!

(after! doom-modeline
  (setq! ledger-amount "Loading...")
  (defun ledger-update-amount ()
    (setq! ledger-amount
           (string-remove-suffix "\n" (shell-command-to-string "fish -c 'fin | head -n 1 | string trim'"))))
  (doom-modeline-def-segment ledger
    "Ledger ammount in bank"
    (propertize ledger-amount 'face 'doom-modeline-info))
  (doom-modeline-def-modeline 'ledger-modeline
    '(bar workspace-name window-number modals matches follow buffer-info remote-host buffer-position word-count parrot selection-info)
    '(ledger compilation objed-state misc-info persp-name battery grip irc mu4e gnus github debug repl lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs checker time))
  (add-to-list 'doom-modeline-mode-alist '(ledger-mode . ledger-modeline))
  (add-hook 'after-save-hook #'ledger-update-amount)
  (ledger-update-amount))
(after! edit-server (edit-server-start))
(after! projectile
  (add-to-list 'projectile-globally-ignored-directories "vendor")
  (add-to-list 'projectile-globally-ignored-directories "build")
  (add-to-list 'projectile-globally-ignored-directories "out")
  (add-to-list 'projectile-globally-ignored-directories "target")
  (add-to-list 'projectile-globally-ignored-directories "zig-out")
  (add-to-list 'projectile-globally-ignored-directories "zig-cache")
  (add-to-list 'projectile-globally-ignored-directories "result")
  (projectile-register-project-type 'latex '("latexmkrc")
                                    :compilation-dir "."
                                    :project-file "latexmkrc"
                                    :compile "latexmk"))
(after! org (setq! org-tags-column -80))
(after! lsp-mode
  (add-to-list 'lsp-language-id-configuration '(matlab-mode . "matlab"))
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection (executable-find "matlab-lsp"))
    :major-modes '(matlab-mode)
    :server-id 'matlab))
  (lsp-semantic-tokens-mode 1))
(after! doom-modeline (display-time))
(after! flyspell
  (setq! ispell-program-name "hunspell"
         ispell-personal-dictionary (expand-file-name "~/.config/hunspell/personal")
         flyspell-lazy-idle-seconds 5)
  (ispell-set-spellchecker-params)
  (ispell-hunspell-add-multi-dic "en_GB,pt_BR,de_DE,fr_FR,es_ES,it_IT,ru_RU")
  ;; (ispell-hunspell-add-multi-dic "en,pt,de,fr,es,it,ru")
  (unless (file-exists-p ispell-personal-dictionary)
    (write-region "" nil ispell-personal-dictionary nil 0)))

;;; map!

(map! :desc "ё" :i "M-е" (lambda (&rest _) (interactive) (insert "ё"))
      :desc "щ" :i "M-ш" (lambda (&rest _) (interactive) (insert "щ"))
      :desc "Next node"                      "M-n"    #'ts-move-next
      :desc "Prev node"                      "M-p"    #'ts-move-prev
      :desc "Outer node"                     "M-o"    #'ts-move-out
      :desc "First child node"               "M-i"    #'ts-move-in
      :desc "Move arguments to the left"     "M-h"    #'swap-argument-to-left
      :desc "Move arguments to the right"    "M-l"    #'swap-argument-to-right
      :desc "Next tree-sitter error"         :n "] E" #'next-ts-error
      :desc "Reselects last selected region" :n "g p" #'reselect-region
      (:leader
       :desc "Add comment at end of line"          "gcA" #'comment-A
       :desc "Expand selection"                 :v "x"   #'lsp-extend-selection
       :desc "Toggle pretty symbols"               "t s" #'toggle-pretty-symbols
       :desc "Toggle flyspell"                     "t p" #'flyspell-mode
       :desc "Format code"                         "g =" #'lsp-format-buffer
       :desc "Spell action menu"                   "z =" #'flyspell-correct-word-before-point
       :desc "Clears search highlight"             "s c" #'evil-ex-nohighlight
       :desc "Go to previous empty line"           "{"   #'go-prev-empty-line
       :desc "Turns MATLAB array into NumPy array" "m p" #'matlab-to-python
       :desc "Go to next empty line"               "}"   #'go-next-empty-line
       :desc "Toggle Popup"                        "C-˜" #'+popup/toggle
       :desc "Window Hydra"                        "wi"  #'+hydra/window-nav/body
       :desc "Delete surrounding FCall"            "dSF" #'delete-surrounding-fcall
       :desc "Open folder in File Manager"         "o i" #'centaur-tabs-open-directory-in-external-application
       (:prefix "f"
        :desc "Open Ledger" "L" (lambda (&rest _) (interactive) (find-file "~/.org/finances/2023.ledger")))
       (:prefix ("l" . "Lang Tools")
        :desc "Langtool check document"     "c" #'langtool-check
        :desc "Langtool done"               "d" #'langtool-check-done
        :desc "Langtool change language"    "l" #'langtool-switch-default-language
        :desc "Langtool correct buffer"     "f" #'langtool-correct-buffer
        :desc "Langtool see error at point" "h" #'langtool-show-message-at-point
        :desc "Display local help"          "o" #'display-local-help)
       (:prefix ("z" . "zoxide/fzf")
        :desc "FZF Directory"               "d" #'fzf-directory
        :desc "FZF Grep"                    "g" #'fzf-grep
        :desc "FZF Git Grep"                "G" #'fzf-git-grep
        :desc "FZF Switch Buffer"           "b" #'fzf-switch-buffer
        :desc "Zoxide Add"                  "a" #'zoxide-add
        :desc "Zoxide Cd"                   "c" #'zoxide-cd
        :desc "Zoxide Find File"            "f" #'zoxide-find-file
        :desc "Zoxide Travel"               "t" #'zoxide-travel
        :desc "Zoxide Remove"               "x" #'zoxide-remove
        :desc "Zoxide Add With Query"       "A" #'zoxide-add-with-query
        :desc "Zoxide Cd With Query"        "C" #'zoxide-cd-with-query
        :desc "Zoxide Find File With Query" "F" #'zoxide-find-file-with-query
        :desc "Zoxide Travel With Query"    "T" #'zoxide-travel-with-query))
      (:map ein:notebook-mode-map
       :desc "Run all Jupyter notebook cells" "C-c a" #'ein:worksheet-execute-all-cells)
      (:map ein:notebooklist-mode-map
       :desc "Stop ein notebook" "C-c C-s" #'ein:stop)
      (:after evil-org
       :map evil-org-mode-map
       :desc "Next field"                   "C-c l" #'org-table-next-field
       :desc "Previous field"               "C-c h" #'org-table-previous-field
       :leader
       :desc "Org-babel execute src-block" :n "m X" #'org-babel-execute-src-block)
      (:mode latex-mode
       :leader
       :desc "Reftex rescan document" "m r" #'reftex-parse-all)
      (:desc "("                         :textobj "(" #'evil-inner-paren-lookahead   #'evil-a-paren-lookahead
       :desc "["                         :textobj "[" #'evil-inner-bracket-lookahead #'evil-a-bracket-lookahead
       :desc "{"                         :textobj "{" #'evil-inner-curly-lookahead   #'evil-a-curly-lookahead
       :desc "<"                         :textobj "<" #'evil-inner-angle-lookahead   #'evil-a-angle-lookahead)
      ;; Those are kinda of already implemented in evil...
      ;; By not inserting them they work on elisp too.
      (:desc "TS Function"               :textobj "f"   (evil-textobj-tree-sitter-get-textobj "function.inner") (evil-textobj-tree-sitter-get-textobj "function.outer")
       :desc "TS Call"                   :textobj "F"   (evil-textobj-tree-sitter-get-textobj "call.inner") (evil-textobj-tree-sitter-get-textobj "call.outer")
       :desc "TS Block"                  :textobj "B"   (evil-textobj-tree-sitter-get-textobj "block.inner") (evil-textobj-tree-sitter-get-textobj "block.outer")
       :desc "TS Argument"               :textobj "a"   (evil-textobj-tree-sitter-get-textobj "parameter.inner") (evil-textobj-tree-sitter-get-textobj "parameter.outer")
       :desc "TS Statement"              :textobj "S"   (evil-textobj-tree-sitter-get-textobj "statement.outer") (evil-textobj-tree-sitter-get-textobj "statement.outer")
       :desc "TS Comment"                :textobj "c"   (evil-textobj-tree-sitter-get-textobj "comment.inner") (evil-textobj-tree-sitter-get-textobj "comment.outer")
       :desc "TS Class"                  :textobj "C"   (evil-textobj-tree-sitter-get-textobj "class.inner") (evil-textobj-tree-sitter-get-textobj "class.outer")
       :desc "TS Conditional"            :textobj "v"   (evil-textobj-tree-sitter-get-textobj "conditional.inner") (evil-textobj-tree-sitter-get-textobj "conditional.outer")
       :desc "TS Loop"                   :textobj "l"   (evil-textobj-tree-sitter-get-textobj "loop.inner") (evil-textobj-tree-sitter-get-textobj "loop.outer"))
      (:desc "Subsentence"               :textobj "."   #'inner-subsentence  #'outer-subsentence
       :desc "Commas"                    :textobj ","   #'inner-commas       #'outer-commas
       :desc "Join paragraph into line." :n       "gj"  #'evil-join-and-move
       :desc "Moves lines up"            :v       "M-k" #'drag-stuff-up
       :desc "Moves lines down"          :v       "M-j" #'drag-stuff-down)
      (:map LaTeX-mode-map
       :desc "Command"        :textobj "M"     #'evil-tex-inner-command #'evil-tex-a-command
       :desc "Insert an \item in list" "\e\r"  #'latex-insert-item-bellow
       :desc "Go to \begin"            "C-$"   #'LaTeX-find-matching-begin
       :desc "Go to \end"              "C-%"   #'LaTeX-find-matching-end
       :leader
       :desc "Shrink tables"           "m b S" #'org-table-shrink)
      (:map dap-mode-map
       :leader
       :prefix ("d" . "dap")
       ;; basics
       :desc "dap next"          "n" #'dap-next
       :desc "dap step in"       "i" #'dap-step-in
       :desc "dap step out"      "o" #'dap-step-out
       :desc "dap continue"      "c" #'dap-continue
       :desc "dap hydra"         "h" #'dap-hydra
       :desc "dap debug restart" "r" #'dap-debug-restart
       :desc "dap debug"         "s" #'dap-debug
       ;; debug
       :prefix ("dd" . "Debug")
       :desc "dap debug recent"  "r" #'dap-debug-recent
       :desc "dap debug last"    "l" #'dap-debug-last
       ;; eval
       :prefix ("de" . "Eval")
       :desc "eval"                "e" #'dap-eval
       :desc "eval region"         "r" #'dap-eval-region
       :desc "eval thing at point" "s" #'dap-eval-thing-at-point
       :desc "add expression"      "a" #'dap-ui-expressions-add
       :desc "remove expression"   "d" #'dap-ui-expressions-remove
       :prefix ("db" . "Breakpoint")
       :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
       :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
       :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
       :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message)
      (:localleader
       :after evil-ledger
       :map ledger-mode-map
       :desc "Edit xact"                  "e" #'ledger-edit-xact
       :desc "Edit xact with calc"        "E" #'ledger-post-edit-amount
       :desc "Edit entry label"           "l" #'ledger-edit-label
       :prefix ("n" . "navigate/select")
       :desc "Go to start of xact"        "b" #'ledger-navigate-beginning-of-xact
       :desc "Go to end of xact"          "e" #'ledger-navigate-end-of-xact
       :desc "Select all xact with date"  "v" #'ledger-select-all-with-date
       :desc "Go to first xact with date" "p" #'ledger-navigate-first-xact-with-date
       :desc "Go to last xact with date"  "n" #'ledger-navigate-last-xact-with-date)
      (:mode ledger-mode
       :leader
       :desc "Go to next day"     "]" #'ledger-navigate-next-day
       :desc "Go to previous day" "[" #'ledger-navigate-previous-day)
      (:leader :desc "Go to Messages buffer" "b e" #'activate-messages-buffer))

;;; LSP

(defun lsp-config ()
  (let ((lua (make-hash-table)))
    (puthash "Lua.workspace.library" (list (expand-file-name "~/.hammerspoon/Spoons/EmmyLua.spoon/annotations")) lua)
    (lsp--set-configuration `(:lua-language-server ,lua))))

(add-hook 'lsp-after-initialize-hook 'lsp-config)
(add-hook 'lsp-mode-hook (lambda () (lsp-semantic-tokens-mode 1)))

;;; DAP

(use-package! dap-mode
  :ensure
  :config
  (dap-ui-mode 1)
  (dap-ui-controls-mode 1)
  (dap-auto-configure-mode 1)
  (setq dap-default-terminal-kind "integrated")
  (require 'dap-lldb)
  (require 'dap-gdb-lldb)
  (dap-gdb-lldb-setup)
  (dap-register-debug-template "Rust::LLDB Run Configuration"
                               (list :type "lldb"
                                     :request "launch"
                                     :name "LLDB::Run"
                                     :gdbpath "rust-lldb"
                                     :target nil
                                     :cwd nil)))
(use-package! dap-cpptools :after lsp-rust :config
              (dap-register-debug-template "Rust::CppTools Run Configuration"
                                           (list :type "cppdbg"
                                                 :request "launch"
                                                 :name "Rust::Run"
                                                 :MIMode "gdb"
                                                 :miDebuggerPath "rust-gdb"
                                                 :environment []
                                                 :program nil
                                                 :cwd "${workspaceFolder}"
                                                 :console "external"
                                                 :dap-compilation "cargo build"
                                                 :dap-compilation-dir "${workspaceFolder}")))
(use-package! dap-python :after python)

;;; Add formatters

(set-formatter! 'misshit  "matlab-beautifier --sparse-add" :modes '(matlab-mode))

;;; defun

;; Move cursor horizontally (vim ze and zs and my z| to center it)
(defun hscroll-cursor-left ()
  "Scrolls horizontally so the cursor is at the first column (vim zs)"
  (interactive "@")
  (set-window-hscroll (selected-window) (current-column)))

(defun hscroll-cursor-right ()
  "Scrolls horizontally so the cursor is at the last column (vim ze)"
  (interactive "@")
  (set-window-hscroll (selected-window) (- (current-column) (window-width) -1)))

(defun hscroll-cursor-center ()
  "Scrolls horizontally so the cursor is centered (my vim z|)"
  (interactive "@")
  (set-window-hscroll (selected-window) (- (current-column) (/ (window-width) 2))))

;; Move screen up and down and center
(defadvice! center-screen (&rest _)
  "Center line after moving screen"
  :after #'evil-scroll-up
  :after #'evil-scroll-down
  :after #'evil-ex-search-next
  (evil-scroll-line-to-center nil))

;; Edits ledger transaction ammount in-place
(defun ledger-edit-xact ()
  "Edits the ammount of current xact"
  (interactive)
  (goto-char (line-beginning-position))
  (let ((end-of-xact (-last-item (ledger-navigate-find-xact-extents (point)))))
    (when (re-search-forward ledger-post-line-regexp end-of-xact t)
      (goto-char (match-end ledger-regex-post-line-group-account)) ;; go to the end of the account
      (let ((end-of-amount (re-search-forward "[-.,0-9]+" nil t)))
        ;; determine if there is an amount to edit
        (if end-of-amount
            (progn
              (goto-char (match-beginning 0))
              (delete-region (match-beginning 0) (match-end 0))
              (push-mark))
          (progn ;;make sure there are two spaces after the account name and go to calc
            (if (search-backward "  " (- (point) 3) t)
                (goto-char (line-end-position))
              (insert "  "))
            (push-mark)))
        (evil-insert 1)))))

;; Edits ledger label
(defun ledger-edit-label ()
  "Edits the transaction label"
  (interactive)
  (ledger-navigate-beginning-of-xact)
  (evil-snipe-f 1 " ")
  (evil-forward-word-begin)
  (when (char-equal (char-after) ?*)
    (evil-forward-word-begin))
  (evil-change-line (point) (line-end-position)))

;; Finds date of transaction at point
(defun ledger-date-at-point ()
  "Retuns the date of the xact at point"
  (save-excursion
    (ledger-navigate-beginning-of-xact)
    (car (split-string (thing-at-point 'line t) " "))))

;; Finds first transaction with date
(defun ledger-navigate-first-xact-with-date (&optional date)
  "Moves to the first xact with date (as one at point)"
  (interactive)
  (or date (setq date (ledger-date-at-point)))
  (goto-char (buffer-end -1))
  (search-forward date)
  (goto-char (line-beginning-position)))

;; Finds last transaction with date
(defun ledger-navigate-last-xact-with-date (&optional date)
  "Moves to the last xact with date (as one at point)"
  (interactive)
  (or date (setq date (ledger-date-at-point)))
  (goto-char (buffer-end 1))
  (search-backward date)
  (goto-char (line-beginning-position)))

;; Go to next day
(defun ledger-navigate-next-day ()
  "Moves to the xact after the last with the same date as the one at point"
  (interactive)
  (ledger-navigate-last-xact-with-date)
  (ledger-navigate-next-xact))

;; Go to previous day
(defun ledger-navigate-previous-day ()
  "Moves to the xact before the first with the same date as the one at point"
  (interactive)
  (ledger-navigate-first-xact-with-date)
  (ledger-navigate-prev-xact-or-directive))

;; Selects all transactions with date
(defun ledger-select-all-with-date (&optional date)
  "Selects all xact with same date (as one at point)"
  (interactive)
  (or date (setq date (ledger-date-at-point)))
  (evil-normal-state)
  (ledger-navigate-last-xact-with-date date)
  (ledger-navigate-end-of-xact)
  (evil-visual-line)
  (ledger-navigate-first-xact-with-date date))

;; Insert \item below current line
(defun latex-insert-item-bellow ()
  "Inserts \\item after line"
  (interactive)
  (unless (current-line-empty-p) (evil-insert-newline-below))
  (latex-insert-item)
  (evil-append-line nil))

;; Test if line is empty
(defun current-line-empty-p ()
  (save-excursion
    (beginning-of-line)
    (looking-at-p "[[:blank:]]*$")))

;; Executes the J key (#'evil-join) on region.
(evil-define-operator evil-join-and-move (beg end)
  "Join text and move point to the end of the line."
  :move-point nil
  :type line
  (let ((marker (make-marker)))
    (move-marker marker (1- end))
    (condition-case nil
        (progn
          (evil-join beg end)
          (goto-char marker)
          (evil-first-non-blank))
      (error nil))))

;; Select subordinate sentence
(defun backward-sexp-until (chars begin)
  (save-excursion
    (-let ((stop nil)
           (sdlim (list ?\( ?\[ ?{))
           (edlim (list ?\) ?\] ?})))
      (while (and (> (point) begin) (not stop))
        (setf stop
              (pcase (char-after)
                ((pred (lambda (c) (member c sdlim)))
                 t)
                ((pred (lambda (c) (member c edlim)))
                 (evil-jump-item)
                 nil)
                ((pred (lambda (c) (member c chars)))
                 t)
                (_ nil)))
        (if stop
            (forward-char)
          (backward-char)))
      (when (looking-at-p "[[:blank:]]")
        (evil-forward-word-begin))
      (point))))
(defun forward-sexp-until (chars end &optional outer)
  (save-excursion
    (-let ((stop nil)
           (sdlim (list ?\( ?\[ ?{))
           (edlim (list ?\) ?\] ?})))
      (while (and (< (point) end) (not stop))
        (setf stop
              (pcase (char-after)
                ((pred (lambda (c) (member c sdlim)))
                 (evil-jump-item)
                 nil)
                ((pred (lambda (c) (member c edlim)))
                 (backward-char)
                 t)
                ((pred (lambda (c) (member c chars)))
                 t)
                (_ nil)))
        (forward-char))
      (when (and outer (looking-at-p "[[:blank:]]"))
        (evil-forward-word-begin))
      (point))))
(defun subsentence-range (delim outer)
  (-let* (((start . end) (bounds-of-thing-at-point 'paragraph))
          (fstart (backward-sexp-until delim start))
          (fend (forward-sexp-until delim end outer)))
    (list (max start fstart) (min end fend))))
(evil-define-text-object inner-subsentence (count &optional beg end type)
  (subsentence-range (list ?: ?\; ?. ?,) nil))
(evil-define-text-object outer-subsentence (count &optional beg end type)
  (subsentence-range (list ?: ?\; ?. ?,) t))
(evil-define-text-object inner-commas (count &optional beg end type)
  (subsentence-range (list ?,) nil))
(evil-define-text-object outer-commas (count &optional beg end type)
  (subsentence-range (list ?,) t))

;; Tide
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq! flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; SPACE+[ and SPACE+] navigation
(defun go-next-empty-line ()
  (interactive)
  (evil-next-visual-line)
  (re-search-forward "^[[:blank:]]*$"))
(defun go-prev-empty-line ()
  (interactive)
  (evil-previous-visual-line)
  (re-search-backward "^[[:blank:]]*$"))

;; Turns MATLAB matrix syntax into python syntax
(defun matlab-to-python ()
  "Turns [0 1; 1 0] into np.array([[0, 1], [1, 0]])"
  (interactive)
  (backward-up-list)
  (mark-sexp)
  (if (use-region-p)
      (let* ((numpy (->> (buffer-substring (region-beginning) (region-end))
                         (s-replace "[" "")
                         (s-replace "]" ";")
                         (s-replace-regexp "[ ;]*;[ ;]*" ";")
                         (s-replace-regexp ";$" "")
                         (s-replace " " ",")
                         (s-replace-regexp ",+" ",")
                         (s-replace ";" "],[")
                         (s-replace-regexp "^," "")
                         (s-replace "," ", ")
                         )))
        (replace-region-contents
         (region-beginning)
         (region-end)
         (lambda () (concat "np.array([[" numpy "]])"))))))

;; Reselect last sected region
(defun reselect-region ()
  "Reselects the last selected region"
  (interactive)
  (evil-normal-state)
  (evil-goto-mark ?>)
  (let ((end (point)))
    (evil-goto-mark ?<)
    (evil-visual-state)
    (goto-char end)))

;; Toggles the damned pretty-symbols
(defun toggle-pretty-symbols ()
  "Toggle pretty symbols in buffer"
  (interactive)
  (setq! pretty-symbols-active (not pretty-symbols-active))
  (if pretty-symbols-active
      (progn (setq! tex-fontify-script t)
             (setq! font-latex-fontify-script t)
             (prettify-symbols-mode 1)
             (font-lock-mode 0)
             (font-lock-mode 1))
    (progn (setq! tex-fontify-script nil)
           (setq! font-latex-fontify-script nil)
           (prettify-symbols-mode 0)
           (font-lock-mode 1))))

;; Adds entries from org-agenda to appt
(defun agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

;; Set up the call to alert
(defun send-notification (title msg)
  (alert (xah-asciify-string msg) :title (xah-asciify-string title)))

;; Designate the window function for my-appt-send-notification
(defun appt-display (min-to-app _ msg)
  (send-notification
   (format "Task in %s minutes" (substring-no-properties min-to-app))
   (substring-no-properties msg)))

;; Removes accents and special chars
(defun xah-asciify-text (&optional @begin @end)
  "Remove accents in some letters and some
   Change European language characters into equivalent ASCII ones, e.g. “café” ⇒ “cafe”.
   When called interactively, work on current line or text selection.

   URL `http://ergoemacs.org/emacs/emacs_zap_gremlins.html'
   Version 2018-11-12"  (interactive)
  (let (($charMap
         [
          ["ß" "ss"]
          ["á\\|à\\|â\\|ä\\|ā\\|ǎ\\|ã\\|å\\|ą\\|ă\\|ạ\\|ả\\|ả\\|ấ\\|ầ\\|ẩ\\|ẫ\\|ậ\\|ắ\\|ằ\\|ẳ\\|ặ" "a"]
          ["æ" "ae"]
          ["ç\\|č\\|ć" "c"]
          ["é\\|è\\|ê\\|ë\\|ē\\|ě\\|ę\\|ẹ\\|ẻ\\|ẽ\\|ế\\|ề\\|ể\\|ễ\\|ệ" "e"]
          ["í\\|ì\\|î\\|ï\\|ī\\|ǐ\\|ỉ\\|ị" "i"]
          ["ñ\\|ň\\|ń" "n"]
          ["ó\\|ò\\|ô\\|ö\\|õ\\|ǒ\\|ø\\|ō\\|ồ\\|ơ\\|ọ\\|ỏ\\|ố\\|ổ\\|ỗ\\|ộ\\|ớ\\|ờ\\|ở\\|ợ" "o"]
          ["ú\\|ù\\|û\\|ü\\|ū\\|ũ\\|ư\\|ụ\\|ủ\\|ứ\\|ừ\\|ử\\|ữ\\|ự"     "u"]
          ["ý\\|ÿ\\|ỳ\\|ỷ\\|ỹ"     "y"]
          ["þ" "th"]
          ["ď\\|ð\\|đ" "d"]
          ["ĩ" "i"]
          ["ľ\\|ĺ\\|ł" "l"]
          ["ř\\|ŕ" "r"]
          ["š\\|ś" "s"]
          ["ť" "t"]
          ["ž\\|ź\\|ż" "z"]
          [" " " "]        ; thin space etc
          ["–" "-"]       ; dash
          ["—\\|一" "--"] ; em dash etc
          ])
        $begin $end)
    (if (null @begin)
        (if (use-region-p)
            (setq $begin (region-beginning) $end (region-end))
          (setq $begin (line-beginning-position) $end (line-end-position)))
      (setq $begin @begin $end @end))
    (let ((case-fold-search t))
      (save-restriction
        (narrow-to-region $begin $end)
        (mapc
         (lambda ($pair)
           (goto-char (point-min))
           (while (search-forward-regexp (elt $pair 0) (point-max) t)
             (replace-match (elt $pair 1))))
         $charMap)))))
(defun xah-asciify-string (@string)
  "Returns a new string. European language chars are changed ot ASCII ones
   e.g. “café” ⇒ “cafe”.
   See `xah-asciify-text'
   Version 2015-06-08"
  (with-temp-buffer
    (insert @string)
    (xah-asciify-text (point-min) (point-max))
    (buffer-string)))

;; Evil-mode parens select with lookahead (jumps to next paren if not inside one)
(defun evil-select-paren-lookahead (open close beg end type count &optional inclusive)
  (interactive)
  (save-excursion
    (condition-case nil
        (evil-select-paren open close beg end type count inclusive)
      ((cons error user-error)
       (let ((new-point (- (search-forward (if (characterp open) (char-to-string open) open)) 1)))
         (evil-select-paren open close new-point (point-max) type count inclusive))))))

;; Deletes the surrounding function call, keeping the current argument. All TS.
(defun delete-surrounding-fcall ()
  (interactive)
  (let ((argpos (evil-inner-arg))
        (callpos (evil-textobj-tree-sitter-function--call.outer)))
    (evil-yank (car argpos) (car (cdr argpos)))
    (if (eq (car argpos) (car callpos))
        (let ((callpos2 (evil-textobj-tree-sitter-function--call.outer 2)))
          (evil-visual-select (car callpos2) (- (car (cdr callpos2)) 1)) )
      (evil-visual-select (car callpos) (- (car (cdr callpos)) 1)))
    (evil-paste-after 1)))

;; Go to the next tree-sitter error
(defun next-ts-error ()
  (interactive)
  (let ((points (list)))
    (tsc-traverse-mapc
     (lambda (props)
       (pcase-let ((`[,error-p ,start-point] props))
         (when error-p
           (push (pos-at-line-col (1- (car start-point)) (cdr start-point)) points))))
     tree-sitter-tree
     [:error-p :start-point])
    (if points
        (goto-char (-last-item (-filter (lambda (x) (> x (point))) points)))
      (message "No errors."))))
(defun pos-at-line-col (l c)
  (save-excursion
    (goto-char (point-min))
    (forward-line l)
    (move-to-column c)
    (point)))

;; Swap arguments
(defun swap-argument-to-left ()
  (interactive)
  (let* ((root (tsc-root-node tree-sitter-tree))
         (pos (evil-textobj-tree-sitter-function--parameter.inner))
         (rnode (tsc-get-named-descendant-for-position-range root (car pos) (cadr pos)))
         (lnode (tsc-get-prev-named-sibling rnode)))
    (when lnode
      (let ((ltext (tsc--node-text lnode))
            (rtext (tsc--node-text rnode)))
        (replace-region-contents (car pos) (cadr pos) (lambda () ltext))
        (replace-region-contents (tsc-node-start-position lnode) (tsc-node-end-position lnode) (lambda () rtext))
        (goto-char (tsc-node-start-position lnode))))))
(defun swap-argument-to-right ()
  (interactive)
  (let* ((root (tsc-root-node tree-sitter-tree))
         (pos (evil-textobj-tree-sitter-function--parameter.inner))
         (lnode (tsc-get-named-descendant-for-position-range root (car pos) (cadr pos)))
         (rnode (tsc-get-next-named-sibling lnode)))
    (when rnode
      (let ((ltext (tsc--node-text lnode))
            (rtext (tsc--node-text rnode)))
        (replace-region-contents (tsc-node-start-position rnode) (tsc-node-end-position rnode) (lambda () ltext))
        (replace-region-contents (car pos) (cadr pos) (lambda () rtext))
        (goto-char (+ (tsc-node-start-position lnode) (length rtext)))
        (evil-forward-word-begin)))))

;; Moves selection using Tree-Sitter
(defun ts-move-out ()
  (interactive)
  (let* ((root (tsc-root-node tree-sitter-tree))
         (start (region-beginning))
         (end (region-end))
         (node (tsc-get-named-descendant-for-position-range root start end))
         (node (if (and (= start (tsc-node-start-position node))
                        (= end (tsc-node-end-position node)))
                   (tsc-get-parent node)
                 node)))
    (evil-visual-select (tsc-node-start-position node) (1- (tsc-node-end-position node)))))
(defun ts-move-in ()
  (interactive)
  (let* ((root (tsc-root-node tree-sitter-tree))
         (start (region-beginning))
         (end (region-end))
         (node (tsc-get-named-descendant-for-position-range root start end))
         (node (if (and (= start (tsc-node-start-position node))
                        (= end (tsc-node-end-position node)))
                   (tsc-get-nth-named-child node 0)
                 node)))
    (evil-visual-select (tsc-node-start-position node) (1- (tsc-node-end-position node)))))
(defun ts-move-next ()
  (interactive)
  (let* ((root (tsc-root-node tree-sitter-tree))
         (start (region-beginning))
         (end (region-end))
         (node (tsc-get-named-descendant-for-position-range root start end))
         (node (if (and (= start (tsc-node-start-position node))
                        (= end (tsc-node-end-position node)))
                   (tsc-get-next-named-sibling node)
                 node)))
    (evil-visual-select (tsc-node-start-position node) (1- (tsc-node-end-position node)))))
(defun ts-move-prev ()
  (interactive)
  (let* ((root (tsc-root-node tree-sitter-tree))
         (start (region-beginning))
         (end (region-end))
         (node (tsc-get-named-descendant-for-position-range root start end))
         (node (if (and (= start (tsc-node-start-position node))
                        (= end (tsc-node-end-position node)))
                   (tsc-get-prev-named-sibling node)
                 node)))
    (evil-visual-select (tsc-node-start-position node) (1- (tsc-node-end-position node)))))

(defun new-buffer-with-content (content)
  (pop-to-buffer (get-buffer-create (generate-new-buffer-name "new")))
  (insert content))

(defun tree-sitter-tree-in-buffer ()
  (interactive)
  (new-buffer-with-content (tsc-node-to-sexp (tsc-root-node tree-sitter-tree))))

;; Goes to Messages buffer
(defun activate-messages-buffer ()
  "Goes to Messages buffer"
  (interactive)
  (switch-to-buffer "*Messages*"))

;; Pastes text with motion
(evil-define-operator paste-over (beg end)
  "Pastes text with motion"
  (evil-visual-select beg (- end 1))
  (evil-paste-after 1))

;; Sets up a version of ([{<>}]) objects with lookahead (vim-like)
(evil-define-text-object evil-a-paren-lookahead (count &optional beg end type)
  "Select a parenthesis."
  :extend-selection nil
  (evil-select-paren-lookahead ?\( ?\) beg end type count t))
(evil-define-text-object evil-inner-paren-lookahead (count &optional beg end type)
  "Select inner parenthesis."
  :extend-selection nil
  (evil-select-paren-lookahead ?\( ?\) beg end type count))
(evil-define-text-object evil-a-bracket-lookahead (count &optional beg end type)
  "Select a square bracket."
  :extend-selection nil
  (evil-select-paren-lookahead ?\[ ?\] beg end type count t))
(evil-define-text-object evil-inner-bracket-lookahead (count &optional beg end type)
  "Select inner square bracket."
  :extend-selection nil
  (evil-select-paren-lookahead ?\[ ?\] beg end type count))
(evil-define-text-object evil-a-curly-lookahead (count &optional beg end type)
  "Select a curly bracket (\"brace\")."
  :extend-selection nil
  (evil-select-paren-lookahead ?{ ?} beg end type count t))
(evil-define-text-object evil-inner-curly-lookahead (count &optional beg end type)
  "Select inner curly bracket (\"brace\")."
  :extend-selection nil
  (evil-select-paren-lookahead ?{ ?} beg end type count))
(evil-define-text-object evil-an-angle-lookahead (count &optional beg end type)
  "Select an angle bracket."
  :extend-selection nil
  (evil-select-paren-lookahead ?< ?> beg end type count t))
(evil-define-text-object evil-inner-angle-lookahead (count &optional beg end type)
  "Select inner angle bracket."
  :extend-selection nil
  (evil-select-paren-lookahead ?< ?> beg end type count))

;; Reload projectile
(defadvice! reload-projectile (&rest _)
  "Reload projectile"
  :before #'projectile-find-file
  (projectile-invalidate-cache nil))

;; Add comment at end of line
(defun comment-A ()
  "Add comment at end of line"
  (interactive)
  (evil-append-line 1)
  (sp-comment)
  (insert " "))

;;; exec

;; Sets up Centaur shortcuts
(dotimes (n 9) (global-set-key (kbd (format "M-%d" n)) #'centaur-tabs-select-visible-tab))
(global-set-key (kbd "M-H" ) #'centaur-tabs-move-current-tab-to-left)
(global-set-key (kbd "M-L" ) #'centaur-tabs-move-current-tab-to-right)

;; Fixes workspace selection
(when IS-LINUX
  (dotimes (n 9)
    (global-set-key
     (kbd (format "s-%d" n))
     (lambda () (interactive) (+workspace/switch-to (1- n))))))

;; Make evil-mode up/down operate in screen lines instead of logical lines
(define-key evil-normal-state-map "j" #'evil-next-visual-line)
(define-key evil-normal-state-map "k" #'evil-previous-visual-line)
;; Also in visual mode
(define-key evil-visual-state-map "j" #'evil-next-visual-line)
(define-key evil-visual-state-map "k" #'evil-previous-visual-line)
;; But not in operator mode
(define-key evil-operator-state-map "j" #'evil-next-line)
(define-key evil-operator-state-map "k" #'evil-previous-line)
;; Emulate some vim movement (and my own)
(define-key evil-normal-state-map "zs" #'hscroll-cursor-left)
(define-key evil-normal-state-map "ze" #'hscroll-cursor-right)
(define-key evil-normal-state-map "z|" #'hscroll-cursor-center)
;; A paste operator
(define-key evil-normal-state-map "gP" #'paste-over)

;; Fix ⌥ in macOS
(when IS-MAC
  (setq! mac-option-modifier 'meta)
  (setq! mac-right-option-modifier 'nil))

;; Fix env file not being loaded. It's a workaround for a bug and should not be
;; necessary.
(when (not (executable-find "texlua"))
  (doom-load-envvars-file doom-env-file))

;; Setups org-agenda notifications
(appt-activate t)                          ;; activate appointment notification
(agenda-to-appt)                           ;; generate the appt list from org agenda files on emacs launch
(run-at-time "24:01" 3600 'agenda-to-appt) ;; update appt list hourly
