class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy, :similar]

  def index
    @movies = Movie.all
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @movie.destroy
    redirect_to root_path, notice: 'Movie was successfully deleted.'
  end

  def similar
    @movie = Movie.find(params[:id])
    if @movie.director.blank?
      redirect_to root_path, notice: "#{@movie.title} has no director info"
    else
      @movies = Movie.where(director: @movie.director).where.not(id: @movie.id)
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date, :director)
  end
end
