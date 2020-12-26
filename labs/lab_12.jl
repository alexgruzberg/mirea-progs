#=На прямоугольном поле 
произвольных размеров расставить 
маркеры в виде "шахматных" клеток, 
начиная с юго-западного угла поля, 
когда каждая отдельная "шахматная" клетка имеет 
размер n x n клеток поля (n - это параметр функции). 
Начальное положение Робота - произвольное, конечное - совпадает с начальным. 
Клетки на севере и востоке могут получаться "обрезанными" - зависит от соотношения 
размеров поля и "шахматных" клеток. 
(Подсказка: здесь могут быть полезными 
две глобальных переменных, в которых будут 
содержаться текущие декартовы координаты Робота 
относительно начала координат в левом нижнем 
углу поля, например)=#
X=0
Y=0
SIZE=0 
function special_chesser(r::Robot, n::Int) #n-параметр функции
    global SIZE, Y, X
    SIZE=n
    vertical=moves!(r,Sud)
    horizontal=moves!(r,West)
    marker_now(r)
    go_back(r,Sud,Y-vertical)
    go_back(r,West,X-horizontal)
end

function to_point(r::Robot, side::HorizonSide) #Смещение по координатам
    global X, Y
    if side==Nord
        Y+=1
    elseif side==Sud
        Y-=1
    elseif side==Ost
        X+=1
    elseif side==West
        X-=1
    end 
    move!(r,side)
end

function marker_now(r::Robot) #Маркировка
    mark_line(r,Ost)
    side=West
    while isborder(r,Nord)==false
        to_point(r,Nord)
        mark_line(r,side)
        side=inverse(side)
    end
end

function mark_line(r::Robot,side::HorizonSide) #Маркировка линии
    term_mark(r,X,Y,SIZE)
    while isborder(r,side)==false
        to_point(r,side)
        term_mark(r,X,Y,SIZE)
    end
end
        
function term_mark(r::Robot, x::Int, y::Int, size::Int) #Условие маркировки
    if ((mod(x,size+size) in 0:size-1)&&(mod(y,size+size) in 0:size-1))==true
        putmarker!(r)
    end
    if ((mod(x,size+size) in size:size+size-1)&&(mod(y,size+size) in size:size+size-1))==true
        putmarker!(r)
    end
end


function moves!(r::Robot,side::HorizonSide) #Описание в предыдущих задачах
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function go_back(r::Robot,side::HorizonSide,num_steps::Int) #Возвращение в исходную клетку
    if (num_steps<0)==true
        side=inverse(side)
        num_steps*=-1
    end
    for a in 1:num_steps
        move!(r,side)
    end
end

function inverse(side::HorizonSide) #Описание в предыдущих задачах и в библиотечном файле
    HorizonSide(mod(Int(side)+2,4))
end
#Данная задача основана на Задаче 7 - добавлены улучшения и новые функции