"""
ДАНО: Робот - в произвольной клетке поля (без внутренних перегородок и маркеров)
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы
"""

function perimetr!(r::Robot) #Основная функция

      first = go_to_point!(r,West) #Робот двигается до западной границы
      second = go_to_point!(r,Sud) #Робот двигается южной границы

      for side in (Nord,Ost,Sud,West) 
        putmarkers!(r,side) 
      end 

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

function putmarkers!(r::Robot, side::HorizonSide) #Робот ставит маркеры, как в Задаче 1 (Возможна реализация через вызов функции в REPL)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end

function go_to_point!(r::Robot,side::HorizonSide,steps::Int) #Возвращается кол-во шагов
    for a in (1:steps)
        move!(r,side) 
    end
end

"""
Использование <go_to_point!> дважды возможно, так как количество аргументов различно.
"""







