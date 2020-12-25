"""
ДАНО: Робот - в произвольной клетке ограниченного прямоугольного поля (без внутренних перегородок)
РЕЗУЛЬТАТ: Робот - в исходном положении, в клетке с роботом стоит маркер, и все остальные клетки поля промаркированы в шахматном порядке
"""
function chesser(r::Robot)
    first=0 #Счётчики шагов
    second=0
    side=Ost
    while (isborder(r,Sud)&&isborder(r,West))==false
        first=moves!(r,West)
        second=moves!(r,Sud)
    end
    if isodd(first+second)==true #Проверка на нечётность (от неё зависит порядок расстановки маркеров!)
        while isborder(r,Nord)==false
            lets_mark_then(r,side)
            side=inverse(side)
            move!(r,Nord)
        end
        lets_mark_then(r,side)
    else
        while isborder(r,Nord)==false
            lets_mark_now(r,side)
            side=inverse(side)
            move!(r,Nord)
        end
        lets_mark_now(r,side)
    end
    go_back_SW(r)
    while first>0
        move!(r,Ost)
        first-=1
    end
    while second>0
        move!(r,Nord)
        second-=1
    end  
end    
function moves!(r::Robot,side::HorizonSide) #Движение и подсчёт шагов
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps=num_steps+1
    end
    return num_steps
end
function lets_mark_now(r::Robot,side::HorizonSide) #Маркировка с данной клетки
    while isborder(r,side)==false
        putmarker!(r)
        move!(r,side)
        if isborder(r,side)==false
            move!(r,side)
        else break    
        end
    end     
end
function lets_mark_then(r::Robot,side::HorizonSide) #Маркировка со следующей клетки
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
        if isborder(r,side)==false
            move!(r,side)
        else break
        end        
    end
end    
function go_back_SW(r::Robot) #Возвращение в ЮЗ угол
    while isborder(r,Sud)==false
        move!(r,Sud)
    end
    while isborder(r,West)==false
        move!(r,West)
    end
end        
function inverse(side::HorizonSide) #Возможно подключение библиотечной функции
    HorizonSide(mod(Int(side)+2, 4))
end
#=Возможна другая реализация функций
и программы в целом=#     
    
