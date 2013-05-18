
a = gets.to_i
if (a > 0) && (Math.sqrt(a) == Math.sqrt(a).truncate) then
	b = Math.sqrt(a)
	matrix = Array.new(b, nil)

	rotate = 0	#поворот 0 - горизонт.; 1 - вертикально.
	direct = 0	#направление 0-вправо; 1-вниз; 2-лево; 3-вверх

	col = 0 	#колонки
	row = 0 	#строки

	indr = b-1	#крайний индекс право верх
	indd = b-1
	indl = 0
	indu = 1 	#т.к. первая строка уже занята

	1.upto(a) do |x|
		matrix[row] = Array.new(b) if matrix[row] == nil
		if (rotate == 0) && (direct == 0) && (col <= indr) then
			matrix[row][col] = x
			col+=1 #переходим к следующей колонке
			
			#Если мы вышли за границу справа
			if (col > indr) then
				rotate = 1
				direct = 1
				col-=1 #возвращаемся назад
				indr-=1 #сдвигаем индекс на еденицу назад
				row+=1 #переходим на следующую строку
			end
		else
			if (rotate == 1) && (direct ==1) && (row <= indd) then
				matrix[row][col] = x
				row+=1 #двигаемся вниз

				if (row > indd) then
					rotate = 0
					direct = 2
					row-=1
					col-=1 #т.к. колонка уже занята
					indd-=1
				end
			else
				if (rotate ==0) && (direct == 2) && (col >= indl) then
					matrix[row][col] = x
					col-=1

					if (col < indl) then
						rotate = 1
						direct = 3
						col+=1
						row-=1
						indl+=1
					end
				else
					if (rotate == 1) && (direct == 3) && (row >= indu) then
						matrix[row][col] = x
						row-=1

						if (row < indu) then
							rotate = 0
							direct = 0
							row+=1
							col+=1
							indu+=1
						end
					end
				end
			end
		end
	end
	matrix.each do |y|
		puts y.to_s
	end
else
	puts "Enter again"
end
