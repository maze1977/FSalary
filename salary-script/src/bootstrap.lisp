(load "utils")
(load "salary-script")

(defun startup () 
    ;; first read all the formula files and compile them:
    (slet (formulaFileNames (directory "formulas/*.txt"))
        (loop for formulaFileName in formulaFileNames
            do 
                (read-list-from-file formulaFileName x                
                    (print x)
                )            
        )
    )

    ;; start the message loop
)


