"""
ДАНО: Робот находится в произвольной клетке ограниченного прямоугольного поля без внутренних перегородок и маркеров.
РЕЗУЛЬТАТ: Робот — в исходном положении в центре прямого креста из маркеров, расставленных вплоть до внешней рамки.
"""

function cross!(r::Robot) #Основная функция
    for side in (Nord,West,Sud,Ost) #Перебор всех возможных направлений
        putmarkers!(r,side)
        move_by_markers!(r,inverse(side))
    end
    putmarker!(r)
end


function putmarkers!(r::Robot,side::HorizonSide)  #Идя в заданном направлении, Робот ставит маркеры, пока не упрётся в стену (то есть пока в заданном направлении нет стены)
    while isborder(r,side)==false 
        move!(r,side)
        putmarker!(r)
    end
end    


function move_by_markers!(r::Robot,side::HorizonSide)  #Робот Двигается по маркерам
    while ismarker(r)==true 
        move!(r,side) 
    end
end    


inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))  #Функция задаёт направление, противоположное данному

"""
На строках 10, 18 и 25 начинаются описания вспомогательных функций.
"""
