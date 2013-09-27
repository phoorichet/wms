class ProjectsController < ApplicationController

  def index
    @projects = Project.all
  end

  def show
    @project = Project.all
  end

  def new
    @project = Project.new
  end


end
