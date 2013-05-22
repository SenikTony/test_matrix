class TMatrix
	@number
	@sqr = nil
	@matrix = nil

	@rotate = 0	#поворот 0 - горизонт.; 1 - вертикально.
	@direct = 0	#направление 0-вправо; 1-вниз; 2-лево; 3-вверх

	@col = 0 	#колонки
	@row = 0 	#строки

	@indr = b-1	#крайний индекс право верх
	@indd = b-1
	@indl = 0
	@indu = 1 	#т.к. первая строка уже занята

	def initialize (number)
		@number = number
	end

	private
	#поворот, поворачиваем спираль и задам направление
	def rotation
		if @rotate == 0
			@rotate = 1
		else
			@rotate = 0
		end

		if @direct <= 3
			@direct+=1
		else
			@direct = 0
		end
	end

	#сдвиг вниз
	def shift_down
		@col-=1
		@row+=1
		@indr-=1
	end

	#сдвиг влево
	def shift_left
		@row-=1
		@col-=1 #т.к. колонка уже занята
		@indd-=1
	end

	#сдвиг вверх
	def shift_up
		@col+=1
		@row-=1
		@indl+=1
	end

	#сдвиг вправо
	def shift_right
		@row+=1
		@col+=1
		@indu+=1		
	end

	#двигаемся по спирали вправо вставляя значения
	def move_to_right (value)
		@matrix[@row] = Array.new(@sqr) if @matrix[@row] == nil #создаём требуемый массив. если такого нет
		@matrix[@row][@col] = value
		@col+=1

		if (@col > @indr)
			rotation
			shift_down
		end
	end

	#двигаемся вниз
	def move_to_down (value)
		@matrix[@row] = Array.new(@sqr) if @matrix[@row] == nil #создаём требуемый массив. если такого нет
		@matrix[@row][@col] = value
		@row+=1

		if (@row > @indd)
			rotation
			shift_left
		end
	end

	#двигаемся влево
	def move_to_left (value)
		@matrix[@row][@col] = value
		@col-=1

		if (@col < @indl)
			rotation
			shift_up
		end
	end

	#двигаемся вверх
	def move_to_up (value)
		@matrix[@row][@col] = value
		@row-=1

		if (@row < @indu)
			rotation
			shift_right
		end
	end

	public

	#проверка условия для построения матрицы
	def checking_condition
		if (@number > 0) && (Math.sqrt(@number) == Math.sqrt(@number).truncate)
			true
		else
			false
		end
	end
	
	#закрутить спираль
	def tighten_spiral
		@sqr = Math.sqrt(@number) #извлекаем корень
		@matrix = Array.new(@sqr, nil) #массив для результата
		
		1.upto(@number) do |val|
			if (@rotate == 0) && (@direct == 0) && (@col <= @indr)
				move_to_right (val)
			elsif (@rotate == 1) && (@direct ==1) && (@row <= @indd)
				move_to_down (val)
			elsif (@rotate ==0) && (@direct == 2) && (@col >= @indl)
				move_to_left (val)
			elsif (@rotate == 1) && (@direct == 3) && (@row >= indu)
				move_to_up (val)
			end
		end
	end

	#вывод результата построчно
	def print_spiral
		@matrix.each do |row|
			puts row.to_s
	end
end

###############################################################################
## Тест ##
###############################################################################

loop do
	puts "Input number"
	number = gets.to_i
	tmatrix = TMatrix.new(number)
	if tmatrix.checking_condition
		tmatrix.tighten_spiral
		tmatrix.print_spiral
		break		
	else
		tmatrix = nil
	end
end

#def test_matrix
#	a = gets.to_i
#	if (a > 0) && (Math.sqrt(a) == Math.sqrt(a).truncate) then
#		b = Math.sqrt(a)
#		matrix = Array.new(b, nil)
#
#		rotate = 0	#поворот 0 - горизонт.; 1 - вертикально.
#		direct = 0	#направление 0-вправо; 1-вниз; 2-лево; 3-вверх
#
#		col = 0 	#колонки
#		row = 0 	#строки
#
#		indr = b-1	#крайний индекс право верх
#		indd = b-1
#		indl = 0
#		indu = 1 	#т.к. первая строка уже занята
#
#		1.upto(a) do |x|
#			matrix[row] = Array.new(b) if matrix[row] == nil
#			if (rotate == 0) && (direct == 0) && (col <= indr) then
#				matrix[row][col] = x
#				col+=1 #переходим к следующей колонке
#			
#				#Если мы вышли за границу справа
#				if (col > indr) then
#					rotate = 1
#					direct = 1
#					col-=1 #возвращаемся назад
#					indr-=1 #сдвигаем индекс на еденицу назад
#					row+=1 #переходим на следующую строку
#				end
#			elsif (rotate == 1) && (direct ==1) && (row <= indd) then
#				matrix[row][col] = x
#				row+=1 #двигаемся вниз
#
#				if (row > indd) then
#					rotate = 0
#					direct = 2
#					row-=1
#					col-=1 #т.к. колонка уже занята
#					indd-=1
#				end
#			elsif (rotate ==0) && (direct == 2) && (col >= indl) then
#				matrix[row][col] = x
#				col-=1
#
#				if (col < indl) then
#					rotate = 1
#					direct = 3
#					col+=1
#					row-=1
#					indl+=1
#				end	
#			elsif (rotate == 1) && (direct == 3) && (row >= indu) then
#				matrix[row][col] = x
#				row-=1
#
#				if (row < indu) then
#					rotate = 0
#					direct = 0
#					row+=1
#					col+=1
#					indu+=1
#				end
#			end
#		end
#		matrix.each do |y|
#			puts y.to_s
#		end
#		true
#	else
#		false
#	end
#end

#loop do
#	puts "Input the number:"
#	break if test_matrix
#end