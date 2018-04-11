(deformula kizula ( p.nr-of-children p.age) (
    p.nr-of-children
         < 4    (p.age 
                        < 15 250
                        >= 15 200)
         >= 4   (p.age 
                        < 15 350
                        >= 15 300))
)