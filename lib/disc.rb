class Disc < Product
  attr_accessor :title, :author, :genres, :year, :price, :amount

  def self.from_file(file_path)
    lines = File.readlines(file_path, encoding: 'UTF-8').map { |l| l.chomp }

    self.new(
      title: lines[0],
      author: lines[1],
      genres: lines[2],
      year: lines[3],
      price: lines[4],
      amount: lines[5].to_i
    )
  end

  def initialize(params)
    super

    @title = params[:title]
    @genres = params[:genres]
    @author = params[:author]
  end

  def update(params)
    super

    @title = params[:title]
    @genre = params[:genres]
  end

  def to_s
    "Альбом #{@title}, #{@genres}, #{@author} #{super}"
  end
end
