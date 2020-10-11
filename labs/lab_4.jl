"""
ДАНО: Робот - Робот - в произвольной клетке ограниченного прямоугольного поля

РЕЗУЛЬТАТ: Робот - в исходном положении, и клетки поля промакированы так: нижний ряд - полностью, следующий - весь, за исключением одной последней клетки на Востоке, следующий - за исключением двух последних клеток на Востоке, и т.д.
"""

function liners!(r::Robot)
    first = go_to_point!(r,West) #Робот двигается до западной границы
    second = go_to_point!(r,Sud) #Робот двигается южной границы

    putmarker!(r)
    side = Ost
    putmarkers!(r,side)
    side = inverse(side)

    back_by_markers!(r,side)
    back_to_point!(r)

    go_to_point!(r,Nord,second) 
    go_to_point!(r,Ost,first) #Возвращение в исходную точку

end


    
function go_to_point!(r::Robot,side::HorizonSide) #Считается кол-во шагов
    steps=0
    while isborder(r,side) == false
        move!(r,side)
        steps=steps+1
    end
    return steps #Возвращает кол-во шагов
end

function go_to_point!(r::Robot,side::HorizonSide,steps::Int) #Возвращается кол-во шагов
    for a in (1:steps)
        move!(r,side) 
    end
end

function putmarkers!(r::Robot,side::HorizonSide)
    while isborder(r,side) == false
        move!(r,side)
        putmarker!(r)
    end
end 

function back_to_point!(r::Robot) #Возвращение в левый нижний угол
    while isborder(r,West)==false
        move!(r,West)
    end    
    while isborder(r,Sud)==false
        move!(r,Sud)
    end            
end

function back_by_markers!(r::Robot,side::HorizonSide) #Робот возвращается по маркерам и маркирует следующую строку
    while isborder(r,Nord) == false
        move!(r,Nord)
        putmarkers!(r,side)
        side = inverse(side)
        while ismarker(r) == true
            move!(r,side)
        end
        side = inverse(side)
        if isborder(r,side) == false
          move!(r,side)
        end
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))  #Функция задаёт направление, противоположное данному




