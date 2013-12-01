class SolutionsController < ApplicationController
  def index
    lim = {}
    lim[:hacker_id] = params[:hacker_id] if params[:hacker_id]
    lim[:puzzle_id] = params[:puzzle_id] if params[:puzzle_id]
    lim[:result] = params[:result] if params[:result]
    @solutions = Solution.where(lim).order('id DESC').page(params[:page]).per(10)
  end

  def show
    @solution = Solution.find(params[:id])
  end

  def new
    authenticate_hacker!

    @solution = Solution.new
    @solution.puzzle_id = params[:puzzle_id]
  end

  def create
    authenticate_hacker!

    @solution = Solution.new(params[:solution].permit(:puzzle_id, :language, :code))
    @solution.hacker_id = current_hacker.id
    @solution.time_cost = -1
    @solution.memory_cost = -1
    @solution.result = "Pending"

    @solution.hacker.language_last_use = @solution.language
    @solution.hacker.save

    if Puzzle.where(id: @solution.puzzle_id).size == 1 && @solution.save
      @solution.delay.judge
      redirect_to solutions_path
    else
      render action: "new"
    end
  end
end
