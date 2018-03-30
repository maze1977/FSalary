


(defun map-conditional-op (op v)
	(if (stringp v) string= op)
)

;; (create-if 'anz-kinder '(> 1  250 > 3 350))
;; becomes:
;; (IF (> ANZ-KINDER 1) 250 (IF (> ANZ-KINDER 3) 350 NIL))


(defun create-if (lst)
	(if (> (list-length lst) 1)
		(let ((attr (nth 0 lst))
			 (condition (nth 1 lst))			
			 (val-to-check (nth 2 lst))
			 (result-val (nth 3 lst))
			 (else-val (cddddr lst))			 
			 )
			 (if (atom result-val)
			 
				`(if (,condition ,attr ,val-to-check) ,result-val ,(create-if (cons attr else-val) ) )
				(let ((x (create-if result-val )))
					`(if (,condition ,attr ,val-to-check) ,x ,(create-if (cons attr else-val) ) )					
				)
			)
		)
	)
)
;; anz-kinder 
;;	(
;;	> 1  250
;;	> 3 350
;;	)

; (setq anz-kinder 4)
; (setq alter 64)
;  (create-ifm (anz-kinder > 1  250 > 3 350))
; -> Ergebnis: 250

(defmacro create-ifm (lst)
	(create-if lst)
)

;; invoke like: (deformula test (anzkinder alter)  (anzkinder < 4 (alter < 30 250 > 30 200) >= 4 (alter < 30 350 > 30 300)))
(defmacro deformula (func-name pars expr)
	`(defun ,func-name ,pars 
			(create-ifm ,expr)
	 )
	 ;; `(defun ,func-name -jahr () 1 )

)