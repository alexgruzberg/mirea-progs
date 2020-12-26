"""
ДАНО: Робот - в произвольной клетке поля (с внутренними перегородками и маркерами)
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки по периметру внешней рамки промакированы
"""
function new_perimeter(r::Robot)
    steps=0
    arr_of_steps=[]
    while ((isborder(r,Sud))&&(isborder(r,West)))==false
        push!(arr_of_steps,moves!(r,West))
        push!(arr_of_steps,moves!(r,Sud))
        steps+=2
    end
    side=Nord
    for a ∈ 1:4
        while isborder(r,side)==false
            putmarker!(r)
            move!(r,side)
        end
        side=inverse(next(side))
    end
    while (steps>0)==true
        side=isodd(steps) ? Ost : Nord
        for a ∈ 1:arr_of_steps[steps]
            move!(r,side)
        end
        steps-=1
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

function next(side::HorizonSide)
    (HorizonSide(mod(Int(side)+1,4)))
end
function inverse(side::HorizonSide)
    (HorizonSide(mod(Int(side)+2,4)))
end
#Функции аналогичны тем, которые описаны в Задаче 5