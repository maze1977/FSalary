(defmacro slet ((x v) &body body)
	`(let ( (,x ,v) ) ,@body)
)

(defmacro read-list-from-file ((file-name variable) &body body)
	`(slet ( in (open ,file-name) ) 
		(slet (,variable (read in)) 
			,@body
		)
		(close in)
	)
)