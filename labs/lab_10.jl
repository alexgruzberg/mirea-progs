"""
ДАНО: Робот - в юго-западном углу поля, на котором расставлено некоторое количество маркеров

РЕЗУЛЬТАТ: Функция вернула значение средней температуры всех замаркированных клеток
"""
N=0 #Количество замаркированных клеток
V=0 #Сумма температур
function average(r::Robot)
    side=Ost
    while isborder(r,Nord)==false
        liner(r,side)
        side=inverse(side)
        move!(r,Nord)
    end
    liner(r,side)
    println(V/N)    
end

function temper(r::Robot) #Пересчёт суммы температур
    global V
    if ismarker(r)==true
        V=V+temperature(r)
    end
end

function counter(r::Robot) #Пересчёт количества маркеров
    global N
    if ismarker(r)==true
        N=N+1
    end 
end   

function liner(r::Robot,side::HorizonSide) #Движение по горизонтали
    while isborder(r,side)==false
        move!(r,side)
        temper(r)
        counter(r)
    end   
end   

function inverse(side::HorizonSide) #Возможно использование библиотечного файла
    HorizonSide(mod(Int(side)+2,4))
end
#= Использованы
глобальные переменные =#
  