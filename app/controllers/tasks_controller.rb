class TasksController < ApplicationController
  before_action :set_user!, only: [:index, :create, :destroy, :update, :move_higher, :move_lower]
  before_action :set_project!, only: [:index, :destroy, :update, :create, :move_higher, :move_lower]

  def index
    if @project.present?
      # render json: @project.tasks.order(created_at: :desc)
      render json: @project.tasks.order(position: :asc)
    else
      render json: {
               error: "project not found",
             }
    end
  end

  def create
    task = @project.tasks.create(name: params[:name], deadline: params[:deadline])
    if task
      render json: task
    else
      render json: {
               error: "unauthenticated",
             }
    end
  end

  def destroy
    task = @project.tasks.find(params[:id])
    if task.destroy
      render json: task
    else
      render json: {
        error: "task not found",
      }
    end
  end

  def update
    task = @project.tasks.find(params[:id])
    attrs = params.require(:task).permit(:name, :done, :deadline)
    if task.update(attrs)
      render json: task
    else
      render json: {
        error: "task not updated",
      }
    end
  end

  def move_higher
    task = @project.tasks.find(params[:task_id])
    if task.move_higher
      render json: task
    else
      render json: {
        error: "can't move task",
      }
    end
  end

  def move_lower
    task = @project.tasks.find(params[:task_id])
    if task.move_lower
      render json: task
    else
      render json: {
        error: "can't move task",
      }
    end
  end

  private

  def set_user!
    @user = User.find_by(token: params[:token])
    if @user.blank?
      render json: { error: "unauthenticated" }
      return false
    end
  end

  def set_project!
    @project = @user.projects.find(params[:project_id])
  end
end
