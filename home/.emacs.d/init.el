(require 'package)

;; (setq url-proxy-services
;;       '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
;;         ("http" . "localhost:8118")
;;         ("https" . "localhost:8118")))

(setq package-check-signature nil)
(setq package-archives
      '(("gnu" . "https://elpa.emacs-china.org/gnu/")
        ("melpa" . "https://elpa.emacs-china.org/melpa/")
	))

(package-initialize)


(unless package-archive-contents
  (package-refresh-contents))

 (dolist (package '(use-package paredit restclient
                    json-mode typescript-mode vue-mode vue-html-mode
                    dap-mode lsp-java lsp-haskell
                    rust-mode cargo
                    dante cider gradle-mode nix-mode
                    ))
   (unless (package-installed-p package)
     (package-install package)))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(setq use-package-always-defer t
      use-package-always-ensure t
      backup-directory-alist `((".*" . ,temporary-file-directory))
      auto-save-file-name-transforms `((".*" ,temporary-file-directory t)))


;; -----------------
;; common
;; -----------------
(require 'flycheck)
(electric-indent-mode 0)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq-default truncate-lines t)

(add-hook 'emacs-lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'clojure-mode-hook #'enable-paredit-mode)
(add-hook 'conf-mode-hook (lambda () (display-line-numbers-mode t)))


;; -----------------
;; nix mode
;; -----------------
(use-package nix-mode
  :mode "\\.nix\\'"
  :init
  (add-hook 'nix-mode-hook 'flycheck-mode))

;; -----------------
;; common lsp
;; -----------------
(require 'lsp-mode)
(setq lsp-file-watch-ignored
  '(".idea" ".ensime_cache" ".eunit" "node_modules"
            ".git" ".hg" ".fslckout" "_FOSSIL_"
            ".bzr" "_darcs" ".tox" ".svn" ".stack-work"
            "build"))

;; -----------------
;; json mode
;; -----------------
(add-hook 'json-mode-hook #'lsp)

;; -----------------
;; typescript mode
;; -----------------
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
(add-hook 'typescript-mode-hook #'lsp)

;; -----------------
;; vue mode
;; -----------------
;; yarn global add vue-language-server
;; yarn global add vscode-css-languageserver-bin
(add-hook 'vue-mode-hook #'lsp)
(with-eval-after-load 'lsp-mode
  (mapc #'lsp-flycheck-add-mode '(typescript-mode js-mode css-mode vue-html-mode)))
;; -----------------
;; c mode
;; -----------------
;; nix-env -f ~/.nix-defexpr/channels/nixos-20.03 -iA clang-tools
(add-hook 'c++-mode-hook #'lsp)

;; -----------------
;; haskell mode
;; -----------------
;; (require 'lsp-haskell)
;; (add-hook 'haskell-mode-hook #'lsp)
(use-package dante
  :ensure t
  :after haskell-mode
  :commands 'dante-mode
  :init
  (add-hook 'haskell-mode-hook 'flycheck-mode)
  (add-hook 'haskell-mode-hook 'dante-mode)
  )

;; -----------------
;; java mode
;; -----------------
(require 'dap-java)
(require 'lsp-java)

;; nix-env -f ~/.nix-defexpr/channels/nixos-20.03 -iA lombok
(setq path-to-lombok (car (file-expand-wildcards "/nix/store/*-lombok-*/share/java/lombok.jar") ) )
(setq lsp-java-vmargs
      `("-noverify"
        "-Xmx1G"
        "-XX:+UseG1GC"
        "-XX:+UseStringDeduplication"
        ,(concat "-javaagent:" path-to-lombok)
        ,(concat "-Xbootclasspath/a:" path-to-lombok)))

(add-hook 'java-mode-hook #'lsp)
(add-hook 'java-mode-hook (lambda ()
                            (setq c-default-style "java")
                            (setq c-basic-offset 4)
                            (display-line-numbers-mode t)
                            (gradle-mode 1)
                            ))

(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$")

(use-package lsp-mode
  ;; Optional - enable lsp-mode automatically in scala files
  :hook  (scala-mode . lsp)
         (lsp-mode . lsp-lens-mode)
  :config (setq lsp-prefer-flymake nil))

;; Add metals backend for lsp-mode
(use-package lsp-metals)

;; (dap-mode 1)
;; (dap-ui-mode 1)

(require 'rust-mode)
(add-hook 'rust-mode-hook #'lsp)
(add-hook 'rust-mode-hook 'cargo-minor-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (htmlize protobuf-mode vue-mode use-package typescript-mode scala-mode rustic restclient paredit nix-mode magit lsp-metals lsp-java lsp-haskell json-mode gradle-mode eglot dante cider cargo))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq org-latex-pdf-process '("xelatex -interaction nonstopmode %f"
"xelatex -interaction nonstopmode %f"))
