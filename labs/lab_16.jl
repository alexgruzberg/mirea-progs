"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля (присутствуют перегородки)
РЕЗУЛЬТАТ: Робот - в исходном положении, и все клетки поля промакированы
"""
function new_all_markers(r::Robot)
    steps=0
    arr_of_steps=[]
    while ((isborder(r,Sud))&&(isborder(r,West)))==false
        push!(arr_of_steps,moves!(r,West))
        push!(arr_of_steps,moves!(r,Sud))
        steps+=2
    end
    putmarker!(r)
    while isborder(r,Ost)==false
        move!(r,Ost)
        putmarker!(r)
    end
    side=West
    while isborder(r,Nord)==false
        oper=1
        move!(r,Nord)
        putmarker!(r)
        while oper!=0
            oper=find_decision(r,side) #Обходчик
            putmarker!(r)
        end
        side=inverse(side)
    end
    moves!(r,West)
    moves!(r,Sud)
    while (steps>0)==true
        side=isodd(steps) ? Ost : Nord
        for a ∈ 1:arr_of_steps[steps]
            move!(r,side)
        end
        steps-=1
    end
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
#=
Описания массива и некоторых вспомогательных функций аналогичны тем,
которые представлены в предыдущих задачах, например, Задаче 5
=#