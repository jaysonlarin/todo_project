class TasksController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_todo#, only: %i[ show edit update destroy ]
  before_action :set_task, only: %i[ show edit update destroy ]

  # GET /tasks or /tasks.json
  def index
    @tasks = @todo.tasks
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = @todo.tasks.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = @todo.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to todo_tasks_url, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: todo_task_path(todo_id: @todo, id: @task) }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      @task.adjust_sequence(task_params[:sequence]) if task_params[:sequence]
      if @task.update(task_params)
        format.html { redirect_to todo_tasks_url(@todo), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    @task.reorder_sequences_after_delete
    respond_to do |format|
      format.html { redirect_to todo_tasks_url, notice: "Task was successfully destroyed." }
      format.json { render :delete, status: 200 }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = @todo.tasks.find(params[:id])
    end

    def set_todo
      @todo = Todo.find(params[:todo_id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      # binding.pry
      params.require(:task).permit(:description, :sequence, :finished)
    end
end
