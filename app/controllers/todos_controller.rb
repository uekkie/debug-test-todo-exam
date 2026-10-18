class TodosController < ApplicationController
  before_action :set_todo, only: %i[show edit update destroy toggle]

  FILTERS = %w[all active completed].freeze

  def index
    @filter = FILTERS.include?(params[:filter]) ? params[:filter] : "all"
    todos = current_user.todos.search(params[:q]).by_due
    todos = todos.active if @filter == "active"
    todos = todos.completed if @filter == "completed"
    @todos = todos
    @active_count = current_user.todos.active.count
  end

  def show
  end

  def new
    @todo = current_user.todos.build
  end

  def create
    @todo = current_user.todos.build(todo_params)
    if @todo.save
      redirect_to todos_path, notice: "登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      redirect_to todo_path(@todo), notice: "更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_path, notice: "削除しました"
  end

  def toggle
    @todo.update!(done: !@todo.done)
    redirect_to todos_path(filter: params[:filter])
  end

  private

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :memo, :due_on, :category_id, :done)
  end
end
