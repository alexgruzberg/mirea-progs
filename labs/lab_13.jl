function x_crosser(r::Robot)
    side=Nord
    for a ∈ 1:4
        while isborder(r,side)==false && isborder(r,next(side))==false #Проверка двух сторон
            move!(r,side)
            move!(r,next(side))
            putmarker!(r)
        end
        side=inverse(side)
        while ismarker(r)
            move!(r,side)
            move!(r,next(side))
        end
        side=inverse(next(side))
    end
    putmarker!(r)
end

function inverse(side::HorizonSide) #Взято из библиотечного файла
    HorizonSide(mod(Int(side)+2,4))
end
function next(side::HorizonSide)
    HorizonSide(mod(Int(side)+1,4))
end
#= Возможна реализация с помощью кортежа #=