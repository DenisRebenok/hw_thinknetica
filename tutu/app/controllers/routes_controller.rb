class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  def index
    @routes = Route.all
  end

  def show
  end

  def new
    @route = Route.new
  end

  def edit
  end

  def create
    @route = Route.new(route_params)
    if @route.save
      redirect_to @route, notice: "Путь успешно создан."
    else
      render :new
    end
  end

  def update
    if @route.update(route_params)
      redirect_to @route, notice: "Путь успешно изменен."
    else
      render :edit
    end
  end

  def destroy
    @route.destroy
    redirect_to routes_path, notice: "Путь успешно удален."
  end

  private

  def set_route
    @route = Route.find(params[:id])
  end

  def route_params
    params.require(:route).permit(:title)
  end
end
