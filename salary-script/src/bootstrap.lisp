(load "utils")
(load "salary-script")

(defun startup ()
    (slet (formulaFileNames (directory "formulas/*.lisp"))
        (progn
            (loop for formulaFileName in formulaFileNames
                do (load formulaFileName)                    
            )
        )
    )
)
