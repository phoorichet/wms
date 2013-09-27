class StaticPagesController < ApplicationController

  # PT:: A method mapped to main page
  def main
  @projects = Project.all
  end
end
