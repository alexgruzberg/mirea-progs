"""Смена направления на противоположное"""
function inverse(side::HorizonSide)
    HorizonSide(mod(Int(side)+2, 4))
end
"""Смена направления на следующее (по стороне горизонта)"""
function next(side::HorizonSide)
    HorizonSide(mod(Int(side)+3,4))
end
"""Движение и подсчёт шагов"""
function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps=num_steps+1
    end
    return num_steps
end
"""Обход локальных преград"""
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