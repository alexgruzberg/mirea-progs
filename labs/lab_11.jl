"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля, на котором могут находиться также внутренние прямоугольные перегородки (все перегородки изолированы друг от друга, прямоугольники могут вырождаться в отрезки)

РЕЗУЛЬТАТ: Робот - в исходном положении, и в 4-х приграничных клетках, две из которых имеют ту же широту, а две - ту же долготу, что и Робот, стоят маркеры.
"""
function coordinat_marker(r::Robot)
    steps=0
    arr_of_steps=[]
    while ((isborder(r,Sud)) && (isborder(r,West)))==false
        push!(arr_of_steps,moves!(r,West))
        push!(arr_of_steps,moves!(r,Sud))
        steps+=2
    end
    vertical=0 #Счётчик - Движение по вертикали
    horizontal=0 #Счётчик - Движение по горизонтали
    for a in 1:steps
        if isodd(a)==true #Проверка на нечётность
            horizontal+=arr_of_steps[a] #Суммирование, значения берутся из массива
        else
            vertical+=arr_of_steps[a]
        end
    end
    side=Nord
    for b in 1:2 #Движение по вертикали и горизонтали
        vertical=coordinater(r,side,vertical) 
        side=next(side)
        horizontal=coordinater(r,side,horizontal)
        side=next(side)
    end
    while (steps>0)==true #Аналогичная функция описана в Задаче 5
        side=isodd(steps) ? Ost : Nord
        move_by_points(r,side,arr_of_steps[steps])
        steps-=1
    end
end

function coordinater(r::Robot, side::HorizonSide, num_steps::Int)#Движение и маркировка
    move_by_points(r,side,num_steps)
    putmarker!(r)
    num_steps=moves!(r,side)
    return num_steps
end

function moves!(r::Robot,side::HorizonSide) #Возвращает количество шагов
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function move_by_points(r::Robot, side::HorizonSide, num_steps::Int) #Движение в заданную сторону
    for b in 1:num_steps #Количество шагов определено
        move!(r,side)
    end
end

function next(side::HorizonSide) #Возможно использование библиотечного файла
    HorizonSide(mod(Int(side)+3,4))
end
#=Возможна реализация с помощью других функций, в частности, <sum> - суммирование элементов массива=#