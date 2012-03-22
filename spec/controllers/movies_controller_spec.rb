require 'spec_helper'

describe MoviesController do
  describe 'finding similar movies' do
    it 'should instantiate @movie with the movie with the id from the params' do
      fake_movie = mock('Movie99', :find_similar_movies => [], :director => 'director1')
      Movie.stub(:find).and_return(fake_movie)
      get 'find_similar_movies', {:id => 99}
      assigns(:movie).should == fake_movie
    end
    it 'should call the model method that finds movies with same director and instantiate @similar_movies with the result' do
      similar_movies = [mock('Movie99.1'), mock('Movie99.2')]
      fake_movie = mock('Movie99', :find_similar_movies => similar_movies, :director => 'director1' )
      Movie.stub(:find).and_return(fake_movie)
      get 'find_similar_movies', {:id => 99}
      assigns(:similar_movies).should == similar_movies
    end
    it 'should select the find_similar_movies view for rendering' do
      similar_movies = [mock('Movie99.1'), mock('Movie99.2')]
      fake_movie = mock('Movie99', :find_similar_movies => similar_movies, :director => 'director1' )
      Movie.stub(:find).and_return(fake_movie)
      get 'find_similar_movies', {:id => 99}
      response.should render_template('find_similar_movies')
    end
    it 'should select the home page for rendering when director is nil' do
      fake_movie = mock('Movie99', :director => nil, :title => 'Movie with no director')
      Movie.stub(:find).and_return(fake_movie)
      get 'find_similar_movies', {:id => 99}
      response.should redirect_to movies_path
    end
  end
end
