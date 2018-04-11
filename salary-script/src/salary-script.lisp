
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

(defmacro deformula (func-name pars expr)
	

	(let ( (combined (concatenate 'string (string func-name) "wrapper")))
        (let ( ( cb (intern combined) ))
        	`(progn
				(defun ,cb  (a b) (+ a b)  )
				(defun ,func-name ,pars  (create-ifm ,expr) )
            )
    	)	
	)
)