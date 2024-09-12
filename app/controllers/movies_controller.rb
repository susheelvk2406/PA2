class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
  def index
    sort_column = params[:sort_by] || 'title'  
    sort_direction = params[:direction] || 'asc'

    @movies = Movie.order("#{sort_column} #{sort_direction}")

    @title_sort = sort_column == 'title' ? sort_direction : nil
    @rating_sort = sort_column == 'rating' ? sort_direction : nil
    @release_sort = sort_column == 'release_date' ? sort_direction : nil
  end

  # GET /movies/1 or /movies/1.json
  def show
    @sort_by = params[:sort_by]
    @direction = params[:direction]

    respond_to do |format|
      format.html # renders the default show.html.erb template
      format.json { render json: @movie }
    end
  end

  # GET /movies/new
  def new
    @movie = Movie.new
    @sort_by = params[:sort_by]
    @direction = params[:direction]

    respond_to do |format|
      format.html # renders the default new.html.erb template
      format.json { render json: @movie }
    end
  end
  
  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
    @sort_by = params[:sort_by]
    @direction = params[:direction]

    respond_to do |format|
      format.html # renders the default edit.html.erb template
      format.json { render json: @movie }
    end
  end
  
  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)
    sort_by = params[:sort_by]
    direction = params[:direction]
  
    respond_to do |format|
      if @movie.save
        format.html { redirect_to movies_path(sort_by: sort_by, direction: direction), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    sort_by = params[:sort_by]
    direction = params[:direction]
  
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movies_path(sort_by: sort_by, direction: direction), notice: "Movie was successfully updated." }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    sort_by = params[:sort_by]
    direction = params[:direction]
  
    @movie.destroy!
  
    respond_to do |format|
      format.html { redirect_to movies_path(sort_by: sort_by, direction: direction), notice: "Movie was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
end
