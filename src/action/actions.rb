module Actions
    def self.move_snake(state)
        next_direction = state.next_direction
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

    private

    def self.calc_next_position(state)
        current_position = state.snake.positions.first
        case state.next_direction
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
end