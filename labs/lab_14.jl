"""
ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля (присутствуют перегородки)
РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, расставленных вплоть до внешней рамки.
"""
function new_cross(r::Robot)
    side=Nord
    for a ∈ 1:4
        x=1
        while x!=0
            x=find_decision(r,side)
            putmarker!(r)
        end
        while ismarker(r)
            find_decision(r,inverse(side))
        end
        side=inverse(next(side))
    end
    putmarker!(r)
end

function find_decision(r::Robot, side::HorizonSide) #Обход локальных преград
    num_steps=0
    while isborder(r,side)==true&&isborder(r,next(side))==false
        move!(r,next(side))
        num_steps+=1
    end
    x=0 #Счётчик
    if isborder(r,side)==false
        move!(r,side)
        x+=1
    end
    if num_steps !=0
        while isborder(r,inverse(next(side)))==true
            move!(r,side)
            x+=1
        end
        for a ∈ 1:num_steps
            move!(r,inverse(next(side)))
        end
    end
    return x #Возвращение значения счётчика
end

function next(side::HorizonSide)
    (HorizonSide(mod(Int(side)+1,4)))
end
function inverse(side::HorizonSide)
    (HorizonSide(mod(Int(side)+2,4)))
end