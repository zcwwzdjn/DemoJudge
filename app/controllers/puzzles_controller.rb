class PuzzlesController < ApplicationController
  def index
    @puzzles = Puzzle.page(params[:page]).per(100)
  end

  def show
    @puzzle = Puzzle.find(params[:id])
  end
end
