
(load "utils")
(load "structures")

(defun is-if (lst)
	(let ( (possible-conditions '(= < > <= >= )) (2nd-sy (nth 1 lst)) )
	(member 2nd-sy possible-conditions)))



(defun create-if (lst)
	(if (is-if lst)
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
				)))
			`(,@lst)
	)
)

(defmacro create-ifm (lst)
	(create-if lst)
)

(defun str-concat (a b ) (string-upcase (concatenate 'string a b)))
(defun append-to-symbol (sy appendix) (str-concat (string sy) appendix))
(defun create-new-symbol (sy appendix) (
	slet (combined (append-to-symbol sy appendix))
	(slet  ( cb (intern combined) )
		`(,@cb)
	)))

(defun prefix-of (s)  (subseq (string s) 0 1))
(defun attr-name-of (s)  (subseq (string s) 2))

;; p.age -> (person-age p)
(defun map-parameter (formula-parameter) 
	(slet (prefix (prefix-of formula-parameter))
		(if (string-equal prefix "P" )
			(slet (varname (attr-name-of formula-parameter) )
				(slet (f-name (find-symbol (str-concat "person-" varname)))
					`(,f-name p)				
				)))))

(defmacro deformula (func-name pars expr)
	(slet (wrapper-func-name (create-new-symbol func-name "wrapper"))
		(slet (wrapper-pars (mapcar #'map-parameter pars) ) 
        	`(progn				
				(defun ,func-name ,pars  (create-ifm ,expr) )
				(defun ,wrapper-func-name (p) (,func-name ,@wrapper-pars)  )
				))))