
(defstruct person name age salary nr-of-children quota sold-items type nr-of-hours-worked 
) 

(setq marco (make-person :name "marco" :age 41 :salary 6500 :nr-of-children 1 :quota 1 :sold-items 5000 :type 1 :nr-of-hours-worked (* 42 4)))
(setq cello (make-person :name "cello" :age 40 :salary 45 :nr-of-children 0 :quota 1 :sold-items 5000 :type 2 :nr-of-hours-worked (* 42 4)))

(defstruct result-with-trace traced-expression result)

