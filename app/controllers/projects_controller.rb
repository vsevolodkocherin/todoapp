class ProjectsController < ApplicationController
  before_action :set_user!, only: [:index, :create, :destroy, :update]

  def index
    if @user
      render json: @user.projects.order(created_at: :desc)
    else
      render json: {
        error: "unauthenticated",
      }
    end
  end

  def create
    name = params[:name]
    # binding.pry
    project = @user.projects.create(name: name)
    if project
      render json: project
    else
      render json: {
        error: "unauthenticated",
      }
    end
  end

  def update
    name = params[:project][:name]
    id = params[:id]
    # binding.pry
    project = @user.projects.find(id)
    if project.update(name: name)
      render json: project
    else
      render json: {
        error: "cannot update",
      }
    end
  end

  def destroy
    id = params[:id]
    project = @user.projects.find(id)
    if project.destroy
      render json: project
    else
      render json: {
        error: "cannot remove project",
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
end
