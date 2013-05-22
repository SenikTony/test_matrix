class TMatrixTightenSpiral
	@number 
	@sqr 
	@matrix

	@rotate #поворот 0 - горизонт.; 1 - вертикально.
	@direct #направление 0-вправо; 1-вниз; 2-лево; 3-вверх

	@col	#колонки
	@row 	#строки

	@indr	#крайний индекс право верх
	@indd	#nil потому что без извлечения корня не орпеделить значение
	@indl
	@indu 	#инициализирован 1-ей т.к. первая строка уже занята

	public

		def initialize (number)
			@number = number
			@rotate = 0
			@direct = 0
			@col = 0
			@row = 0
			@indl = 0
			@indu = 1
		end

		#проверка условия для построения матрицы
		def checking_condition
			@number = @number.to_i
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
			@indr = @sqr - 1 #вычисляем значения индекса для правых углов
			@indd = @sqr - 1
		
			1.upto(@number) do |val|
				if (@rotate == 0) && (@direct == 0) && (@col <= @indr)
					move_to_right (val)
				elsif (@rotate == 1) && (@direct ==1) && (@row <= @indd)
					move_to_down (val)
				elsif (@rotate ==0) && (@direct == 2) && (@col >= @indl)
					move_to_left (val)
				elsif (@rotate == 1) && (@direct == 3) && (@row >= @indu)
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

	private
	
		#поворот, поворачиваем спираль и задам направление
		def rotation
			if @rotate == 0
				@rotate = 1
			else
				@rotate = 0
			end

			if @direct < 3
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

		#добавить значания в матрицу
		def add_val_to_matrix (value)
			@matrix[@row] = Array.new(@sqr) if @matrix[@row] == nil #создаём требуемый массив. если такого нет
			@matrix[@row][@col] = value
		end

		#двигаемся по спирали вправо вставляя значения
		def move_to_right (value)
			add_val_to_matrix (value)
			@col+=1

			if (@col > @indr)
				rotation
				shift_down
			end
		end

		#двигаемся вниз
		def move_to_down (value)
			add_val_to_matrix (value)
			@row+=1

			if (@row > @indd)
				rotation
				shift_left
			end
		end

		#двигаемся влево
		def move_to_left (value)
			add_val_to_matrix (value)
			@col-=1

			if (@col < @indl)
				rotation
				shift_up
			end
		end

		#двигаемся вверх
		def move_to_up (value)
			add_val_to_matrix (value)
			@row-=1

			if (@row < @indu)
				rotation
				shift_right
			end
		end
end

###############################################################################
## Тест ##
###############################################################################

loop do
	puts "Input number:"
	number = gets
	tmatrix = TMatrixTightenSpiral.new(number)

	if tmatrix.checking_condition
		tmatrix.tighten_spiral
		tmatrix.print_spiral
		tmatrix = nil
		break		
	else
		tmatrix = nil
	end
end