"""
ДАНО: На ограниченном внешней прямоугольной рамкой поле имеется ровно одна внутренняя перегородка в форме прямоугольника. Робот - в произвольной клетке поля между внешней и внутренней перегородками.
РЕЗУЛЬТАТ: Робот - в исходном положении и по всему периметру внутренней перегородки поставлены маркеры.
"""
function framer(r::Robot)
    steps=0
    arr_of_steps=[]
    while ((isborder(r,Sud)) && (isborder(r,West)))==false
        push!(arr_of_steps,moves!(r,West))
        push!(arr_of_steps,moves!(r,Sud))
        steps=steps+2
    end
    side=Nord
    while isborder(r,Ost)==false
        while isborder(r,side)==false
            move!(r,side)  
            if isborder(r,Ost)==true #Встретилась перегородка
                break #Выход из цикла
            end        
        end
        if isborder(r,Ost)==false
            move!(r,Ost)
        end
        side=inverse(side) #Смена направления на противоположное
    end
    while isborder(r,Ost)==true
        move!(r,Sud)
    end
    side=Nord
    for a ∈ 1:4
        putmarker!(r)
        move!(r,side)
        while isborder(r,next(side))==true #Установка маркеров по периметру рамки
            putmarker!(r)
            move!(r,side)
        end
        side=next(side) #Смена направления на следующее
    end
    moves!(r,Sud)
    moves!(r,West)
    while (steps>0)==true
        side=isodd(steps) ? Ost : Nord
        for a ∈ 1:arr_of_steps[steps]
            move!(r,side)
        end
        steps=steps-1
    end
end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function inverse(side::HorizonSide)
    HorizonSide(mod(Int(side)+2,4))
end
function next(side::HorizonSide)
    HorizonSide(mod(Int(side)+3,4))
end
#= Действия, описание которых начинается с 39-й строки,
выполняются аналогично тем, которые описаны в Задаче 5 =#