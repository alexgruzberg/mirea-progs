"""
ДАНО: Робот - Робот - в произвольной клетке ограниченного прямоугольного поля (присутствуют перегородки)
РЕЗУЛЬТАТ: Робот - в исходном положении, и клетки поля промакированы так: нижний ряд - полностью, следующий - весь, за исключением одной последней клетки на Востоке, следующий - за исключением двух последних клеток на Востоке, и т.д.
"""
function stepper(r::Robot) #Маркировка "лесенкой"
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
    counter=moves!(r,West)
    while isborder(r,Nord)==false && counter>0
        point=counter
        move!(r,Nord)
        while point>0
            putmarker!(r)
            point-=find_decision(r,Ost)
        end
        user_decision(r,West)
        counter-=1
    end
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

function user_decision(r::Robot, side::HorizonSide)
    x=1
    while x!=0
        x=find_decision(r,side)
    end
end

function next(side::HorizonSide)
    (HorizonSide(mod(Int(side)+1,4)))
end
function inverse(side::HorizonSide)
    (HorizonSide(mod(Int(side)+2,4)))
end
