module MoviesHelper
  def toggle_sort_direction(column)
    if @sort_column == column
      @sort_direction == 'asc' ? 'desc' : 'asc'
    else
      'asc'
    end
  end
end