"""
ДАНО: Робот - рядом с горизонтальной перегородкой (под ней), бесконечно продолжающейся в обе стороны, в которой имеется проход шириной в одну клетку.
РЕЗУЛЬТАТ: Робот - в клетке под проходом
"""

function go_to_exit!(r)
    side=Ost
    while isborder(r,Nord)==true 
        putmarker!(r)
        move_by_markers!(r,side)
        side=inverse(side)
    end
end

function move_by_markers!(r::Robot,side::HorizonSide)
    while ismarker(r) 
        move!(r,side) 
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))