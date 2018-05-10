(deformula monthly (p.salary p.quota p.nr-of-hours-worked p.type) 
(  p.type = 1
                (p.salary * p.quota)
            = 2
                (p.nr-of-hours-worked * p.salary)
 ))