(deformula bonus (p.sold-items p.salary )  (
    p.sold-items >= 1000 ( (p.sold-items - 1000) * p.salary )
                 < 1000 0)
)