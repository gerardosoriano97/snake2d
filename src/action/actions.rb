module Actions
    def self.move_snake(state)
        next_direction = state.current_direction
        next_position = calc_next_position(state)
        # verificar que la siguiente casilla sea valida
        if position_is_valid?(state, next_position)
            # si es valida, se mueve la serpiente
            move_snake_to(state, next_position)
        else
            # de lo contrario, se acaba el juego
            end_game(state) 
        end
    end
    def self.change_direction(state, direction)
        if next_direction_is_valid?(state, direction)
            state.current_direction = direction
        else
            puts "Invalid direction"
        end
        state
    end

    private

    def self.calc_next_position(state)
        current_position = state.snake.positions.first
        case state.current_direction
        when Model::Direction::UP
            #decrementar fila
            return Model::Coord.new(
                current_position.row - 1,
                current_position.col
            )
        when Model::Direction::RIGHT
            #incrementar columna
            return Model::Coord.new(
                current_position.row,
                current_position.col + 1
            )
        when Model::Direction::DOWN
            #incrementar fila
            return Model::Coord.new(
                current_position.row + 1,
                current_position.col
            )
        when Model::Direction::LEFT
            #decrementar columna
            return Model::Coord.new(
                current_position.row,
                current_position.col - 1
            )
        end
    end
    def self.position_is_valid?(state, position)
        #verificar que este en la grilla
        is_invalid = ((position.row >= state.grid.rows ||
            position.row < 0) ||
            (position.col >= state.grid.cols ||
            position.col < 0))

        return false if is_invalid
        #verificar que no este superponiendo a la serpiente
        return !(state.snake.positions.include? position)
    end
    def self.move_snake_to(state, next_position)
        new_positions = [next_position] + state.snake.positions[0...-1]
        state.snake.positions = new_positions
        state
    end
    def self.end_game(state) 
        state.game_finished = true
        state
    end
    def self.next_direction_is_valid?(state, direction) 
        case state.current_direction
        when Model::Direction::UP
            return true if direction != Model::Direction::DOWN
        when Model::Direction::RIGHT
            return true if direction != Model::Direction::LEFT
        when Model::Direction::DOWN
            return true if direction != Model::Direction::UP
        when Model::Direction::LEFT
            return true if direction != Model::Direction::RIGHT
        end
        return false
    end
end