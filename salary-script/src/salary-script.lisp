
(load "utils")
(load "structures")

(defun is-if (lst)	
		(let ( (possible-conditions '(= < > <= >= )) (2nd-sy (nth 1 lst)) )
			(member 2nd-sy possible-conditions)))
	
	

(defun is-let (lst)
	(slet (1st (nth 0 lst))
		(string= (string 1st) "LET")
	)
)

(defun handle-salary-script (lst)
	(if (not (atom lst))
		(if (is-if lst)
			(let ((attr (nth 0 lst))
				(condition (nth 1 lst))			
				(val-to-check (nth 2 lst))
				(result-val (nth 3 lst))
				(else-val (cddddr lst))			 
				)
				(if (atom result-val)			 
					`(if (,condition ,attr ,val-to-check) ,result-val ,(handle-salary-script (cons attr else-val) ) )
					(let ((x (handle-salary-script result-val )))
						`(if (,condition ,attr ,val-to-check) ,x ,(handle-salary-script (cons attr else-val) ) )					
					))
			)
			(if (is-let lst)
				(let (
						(var (nth 1 lst))
						(value (nth 3 lst))
						(expr (nth 4 lst))
					)
					(if (atom value)
					`(slet (,var ,value)  (handle-salary-script ,expr)  )
						(slet (x (handle-salary-script value ))
						`(slet (,var ,x)  (handle-salary-script ,expr)  )
						)
					)
		)
		lst
		)
		)
		lst
	)
)

(defmacro handle-salary-script-macro (lst)
	(handle-salary-script lst)
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
				(defun ,func-name ,pars  (handle-salary-script-macro ,expr) )
				(defun ,wrapper-func-name (p) (,func-name ,@wrapper-pars)  )
				))))