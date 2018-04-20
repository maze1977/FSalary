
(load "utils")
(load "structures")

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

(defmacro create-ifm (lst)
	(create-if lst)
)


;; p.age -> (person-age p)

(defun symbol-append (&rest symbols) 
  (intern (apply #'concatenate 'string 
                 (mapcar #'symbol-name symbols))))


;; p.age -> (person-age p)
(defun map-parameter (formula-parameter) 
	(slet (firstchar (subseq (string formula-parameter) 0 1))
		(if (string-equal firstchar "P" )
			(slet (varname (subseq (string formula-parameter) 2))				
				(slet (f-name (find-symbol (string-upcase (concatenate 'string "person-" varname))))
					`(,f-name p)				
				)))))


(defmacro deformula (func-name pars expr)
	(let ( (combined (string-upcase (concatenate 'string (string func-name) "wrapper"))))
        (let ( ( cb (intern combined) ))
			(slet (parpars (mapcar #'map-parameter pars) ) 
        	`(progn				
				(defun ,func-name ,pars  (create-ifm ,expr) )				
				(defun ,cb  (p) (,func-name ,@parpars)  )
				)
            ))))