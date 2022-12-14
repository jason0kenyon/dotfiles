;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Jason Kenyon"
      user-mail-address "jason0kenyon@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-variable-pitch-font (font-spec :family "SourceSansPro" :size 36 ))
(setq doom-big-font (font-spec :family "SourceCodePro" :weight 'semibold :size 46 ))
(setq doom-font (font-spec :family "SourceCodePro" :size 42 :weight 'semibold ))

(setq doom-theme 'doom-city-lights)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq doom-modeline-height 70)
(add-to-list 'load-path "~/.local/share/icons-in-terminal/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
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


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!

(add-to-list 'load-path "~/.local/share/icons-in-terminal/")
(add-hook 'company-mode-hook 'company-box-mode)

(setq company-box-icons-unknown 'fa_question_circle)

(setq company-box-icons-elisp
   '((fa_tag :face font-lock-function-name-face) ;; Function
     (fa_cog :face font-lock-variable-name-face) ;; Variable
     (fa_cube :face font-lock-constant-face) ;; Feature
     (md_color_lens :face font-lock-doc-face))) ;; Face

(setq company-box-icons-yasnippet 'fa_bookmark)

(setq company-box-icons-lsp
      '((1 . fa_text_height) ;; Text
        (2 . (fa_tags :face font-lock-function-name-face)) ;; Method
        (3 . (fa_tag :face font-lock-function-name-face)) ;; Function
        (4 . (fa_tag :face font-lock-function-name-face)) ;; Constructor
        (5 . (fa_cog :foreground "#FF9800")) ;; Field
        (6 . (fa_cog :foreground "#FF9800")) ;; Variable
        (7 . (fa_cube :foreground "#7C4DFF")) ;; Class
        (8 . (fa_cube :foreground "#7C4DFF")) ;; Interface
        (9 . (fa_cube :foreground "#7C4DFF")) ;; Module
        (10 . (fa_cog :foreground "#FF9800")) ;; Property
        (11 . md_settings_system_daydream) ;; Unit
        (12 . (fa_cog :foreground "#FF9800")) ;; Value
        (13 . (md_storage :face font-lock-type-face)) ;; Enum
        (14 . (md_closed_caption :foreground "#009688")) ;; Keyword
        (15 . md_closed_caption) ;; Snippet
        (16 . (md_color_lens :face font-lock-doc-face)) ;; Color
        (17 . fa_file_text_o) ;; File
        (18 . md_refresh) ;; Reference
        (19 . fa_folder_open) ;; Folder
        (20 . (md_closed_caption :foreground "#009688")) ;; EnumMember
        (21 . (fa_square :face font-lock-constant-face)) ;; Constant
        (22 . (fa_cube :face font-lock-type-face)) ;; Struct
        (23 . fa_calendar) ;; Event
        (24 . fa_square_o) ;; Operator
        (25 . fa_arrows)) ;; TypeParameter
      )

(after! company
(setq company-idle-delay
      (lambda () (if (company-in-string-or-comment) nil 0)))

(setq company-minimum-prefix-length 1)
(setq company-selection-wrap-around t)
(company-tng-configure-default)
)

(defun org-roam-node-insert-immediate (arg &rest args)
  (interactive "P")
  (let ((args (cons arg args))
        (org-roam-capture-templates (list (append (car org-roam-capture-templates)
                                                  '(:immediate-finish t)))))
    (apply #'org-roam-node-insert args)))
(map!
 :leader
 (:prefix ("n r" . "node roam")
  :desc "quick insert" "i" #'org-roam-node-insert-immediate)
 )
(map! :leader
      :desc "Org babel tangle" "m B" #'org-babel-tangle)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))

(after! org

        (setq org-directory "~/projects/org/")
        (setq org-roam-directory "~/projects/org/org-roam/")
        (setq org-agenda-files '("~/projects/org/org-roam"))
                )

        (setq org-roam-capture-templates
              '(("t" "daily" plain
                 "* Journal\n\n%?\n\n* Tasks\n\n** TODO [/]\n1. [ ] Mindfulness(10min)\n2. [ ] Journaling(10min)\n3. [ ] Review Notes(10min)\n4. [ ] Check Out\n\n** Notes"
                 :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Daily")
                 :unnarrowed t)

                ("d" "default" plain
                 "%?"
                :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                :unnarrowed t)
                ))

(set-email-account! "jason0kenyon"
  '((mu4e-sent-folder       . "/jason0kenyon/Sent Mail")
    (mu4e-drafts-folder     . "/jason0kenyon/Drafts")
    (mu4e-trash-folder      . "/jason0kenyon/Trash")
    (mu4e-refile-folder     . "/jason0kenyon/All Mail")
    (smtpmail-smtp-user     . "jason0kenyon@gmail.com")
    (user-mail-address      . "jason0kenyon@gmail.com")    ;; only needed for mu < 1.4
    (mu4e-compose-signature . "---\nJason Kenyon"))
  t)


(after! mu4e
(setq mu4e-maildir-shortcuts
    '((:maildir "/Inbox"    :key ?i)
      (:maildir "/[Gmail]/Sent Mail" :key ?s)
      (:maildir "/[Gmail]/Trash"     :key ?t)
      (:maildir "/[Gmail]/Drafts"    :key ?d)
      (:maildir "/[Gmail]/All Mail"  :key ?a)))

  )
(setq
    send-mail-function 'smtpmail-send-it
    smtpmail-smtp-server "smtp.gmail.com"
    smtpmail-smtp-service 25
)

(setq elfeed-feeds
                   '(("http://arxiv.org/rss/math.MP" Papers Physics)
                    ("http://arxiv.org/rss/math.QA" Papers QuantAlg)
                    ))
