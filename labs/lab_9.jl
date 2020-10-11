"""
ДАНО: Где-то на неограниченном со всех сторон поле и без внутренних перегородок имеется единственный маркер. Робот - в произвольной клетке поля.
РЕЗУЛЬТАТ: Робот - в клетке с тем маркером.
"""

function detective!(r)
    steps=1
    side=Nord
    while ismarker(r)==false
        for a in 1:2
            detective!(r,side,steps)
            side=next_dir(side)
        end
        steps+=1
    end
end

function detective!(r,side,steps)
    for a in 1:steps
        if ismarker(r) == true
            return nothing
        end
        move!(r,side)
    end
end

next_dir(side::HorizonSide)=HorizonSide(mod(Int(side)+1,4))