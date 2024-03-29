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
(setq doom-variable-pitch-font (font-spec :family "Monoid" :size 36 ))
(setq doom-big-font (font-spec :family "Monoid" :weight 'semi-bold :size 46 ))
(setq doom-font (font-spec :family "Monoid" :weight 'semi-bold :size 42 ))

(setq doom-theme 'doom-ephemeral)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)
(setq doom-modeline-height 70)

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

(add-hook 'text-mode-hook 'company-box-mode)

(add-hook 'text-mode-hook
          (lambda ()
            (push '("\\mathbb{C}" . ?ℂ) prettify-symbols-alist)))
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
              '(("t" "default" plain
                 "%?"
                :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n")
                :unnarrowed t)

                ("d" "daily" plain
                 "* Journal\n\n%?\n\n* Tasks\n** TODO [/]\n1. [ ] Mindfulness(10min)\n2. [ ] Journaling(5min)\n3. [ ] Review Notes(5min)\n4. [ ] Check Out\n** Notes"
                 :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Daily\n#+category: Daily")
                 :unnarrowed t)

                ("w" "weekly" plain
                 "* Brainstorm\n\n%?\n\n* Note Review\n\n* Agenda"
                 :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Daily\n#+category: Weekly")
                 :unnarrowed t)

                ("a" "aim" plain
                 "* Priority III\n\n* Statement\n\n%?\n\n* Action Plan\n** Maintenance\n** Overview\n\n* Week\n** One\n*** TODO\n*** Commments & Meta-cognition\n\n* Deadlines"
                 :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org" "#+title: ${title}\n#+filetags: Daily\n#+category: Aim")
                 :unnarrowed t)

                ))

(after! org
(setq
    org-fancy-priorities-list '("❗" "[B]" "[C]")
   ;;org-fancy-priorities-list '("🟥" "🟧" "🟨")
   org-priority-faces
   '((?A :foreground "#ff6c6b" :weight bold)
     (?B :foreground "#98be65" :weight bold)
     (?C :foreground "#c678dd" :weight bold))
   org-agenda-block-separator 8411)

(setq org-agenda-custom-commands
      '(("v" "A better agenda view"
         ((tags "PRIORITY=\"A\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "High-priority unfinished tasks:")))
          (tags "PRIORITY=\"B\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Medium-priority unfinished tasks:")))
          (tags "PRIORITY=\"C\""
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Low-priority unfinished tasks:")))
          (tags "customtag"
                ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                 (org-agenda-overriding-header "Tasks marked with customtag:")))

          (agenda "")
          (alltodo ""))))))

(set-email-account! "jason0kenyon"
  '((mu4e-sent-folder       . "/jason0kenyon/Sent Mail")
    (mu4e-drafts-folder     . "/jason0kenyon/Drafts")
    (mu4e-trash-folder      . "/jason0kenyon/Trash")
    (mu4e-refile-folder     . "/jason0kenyon/All Mail")
    (smtpmail-smtp-user     . "jason0kenyon@gmail.com")
    (user-mail-address      . "jason0kenyon@gmail.com")    ;; only needed for mu < 1.4
    (mu4e-compose-signature . "---\nJason Kenyon"))
  t)
(set-email-account! "jkenyon3"
  '((mu4e-sent-folder       . "/jkenyon3/Sent Mail")
    (mu4e-drafts-folder     . "/jkenyon3/Drafts")
    (mu4e-trash-folder      . "/jkenyon3/Trash")
    (mu4e-refile-folder     . "/jkenyon3/All Mail")
    (smtpmail-smtp-user     . "jkenyon3@binghamton.edu")
    (user-mail-address      . "jkenyon3@binghamton.edu")    ;; only needed for mu < 1.4
    (mu4e-compose-signature . "---\nJason Kenyon"))
  t)


(after! mu4e
(setq mu4e-maildir-shortcuts
    '((:maildir "/jason0kenyon/Inbox"    :key ?i)
      (:maildir "/jason0kenyon/[Gmail]/Sent Mail" :key ?s)
      (:maildir "/jason0kenyon/[Gmail]/Trash"     :key ?t)
      (:maildir "/jason0kenyon/[Gmail]/Drafts"    :key ?d)
      (:maildir "/jason0kenyon/[Gmail]/All Mail"  :key ?a)))
(setq mu4e-maildir-shortcuts
    '((:maildir "/jkenyon3/Inbox"    :key ?i)
      (:maildir "/jkenyon3/[Gmail]/Sent Mail" :key ?s)
      (:maildir "/jkenyon3/[Gmail]/Trash"     :key ?t)
      (:maildir "/jkenyon3/[Gmail]/Drafts"    :key ?d)
      (:maildir "/jkenyon3/[Gmail]/All Mail"  :key ?a)))

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
