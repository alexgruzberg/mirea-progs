"""
Условие аналогично тому, которое дано в Задаче 5
"""
function new_mark_4(r::Robot)
    steps=0
    arr_of_steps=[] #Массив
    while ((isborder(r,Sud))&&(isborder(r,West)))==false
        push!(arr_of_steps,moves!(r,West)) #Добавление элемента в конец массива
        push!(arr_of_steps,moves!(r,Sud))
        steps=steps+2 #Счётчик обхода
    end
    for side in (Nord,Ost,Sud,West)
        moves!(r,side)
        putmarker!(r)
    end
    while (steps>0)==true
        side=isodd(steps) ? Ost : Nord #Тернарный оператор
        for a in 1:arr_of_steps[steps]
            move!(r,side)
        end
        steps=steps-1
    end
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps=num_steps+1
    end
    return num_steps
end
