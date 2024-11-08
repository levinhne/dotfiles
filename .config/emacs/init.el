;;; init.el --- Main initialization routine -*- lexical-binding: t; -*-

;; GNU Emacs / N Λ N O - Emacs made simple
;; Copyright (C) 2023-2024 - N Λ N O developers

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; The main initialization code. Contains general settings and
;; installation of dependencies.

;;; Code:

(setq nano-font-family-monospaced "Fira Code Retina")
(setq nano-font-family-proportional "Liberation Serif")
(setq nano-font-size 12)

;; Libraries load path
(add-to-list 'load-path
             (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path
             (expand-file-name "theme" user-emacs-directory))

;; Setup dependencies
(require 'nano-package)

(setq package-list
      '(cape                ; Completion At Point Extensions
        orderless           ; Completion style for matching regexps in any order
        vertico             ; VERTical Interactive COmpletion
        marginalia          ; Enrich existing commands with completion annotations
        consult             ; Consulting completing-read
        corfu               ; Completion Overlay Region FUnction
        deft                ; Quickly browse, filter, and edit plain text notes
        elpher              ; A friendly gopher and gemini client 
        elfeed              ; Emacs Atom/RSS feed reader
        elfeed-org          ; Configure elfeed with one or more org-mode files
        f                   ; Modern API for working with files and directories
        citar               ; Citation-related commands for org, latex, markdown
        citeproc            ; A CSL 1.0.2 Citation Processor
        flyspell-correct-popup ; Correcting words with flyspell via popup interface
        flyspell-popup      ; Correcting words with Flyspell in popup menus
        guess-language      ; Robust automatic language detection
        helpful             ; A better help buffer
        htmlize             ; Convert buffer text and decorations to HTML
        mini-frame          ; Show minibuffer in child frame on read-from-minibuffer
        imenu-list          ; Show imenu entries in a separate buffer
        magit               ; A Git porcelain inside Emacs.
        markdown-mode       ; Major mode for Markdown-formatted text
        multi-term          ; Managing multiple terminal buffers in Emacs.
        pinentry            ; GnuPG Pinentry server implementation
        use-package         ; A configuration macro for simplifying your .emacs
        vc-backup           ; VC backend for versioned backups
        yaml-mode           ; YAML mode
        consult-recoll      ; Consult interface for recoll query
        org-auto-tangle     ; Tangle org file when it is saved
        org-modern          ; Modern Org-mode configuration
        exec-path-from-shell; Get environment variables such as $PATH from the shell 
        treesit-auto             ; Automatic installation, usage, and fallback for tree-sitter major modes in Emacs 29
        which-key))         ; Display available keybindings in popup

            
;; Install packages that are not yet installed
(dolist (package package-list)
  (straight-use-package package))

;; Replace keywords with SVG tags
(straight-use-package
 '(svg-tag-mode :type git :host github :repo "rougier/svg-tag-mode"))

(straight-use-package
 '(org-margin :type git :host github :repo "rougier/org-margin"))

;; Dashboard for mu4e
;(straight-use-package
; '(mu4e-dashboard :type git :host github :repo "rougier/mu4e-dashboard"))

;; Load settings
(require 'nano)

;;; init.el ends here
