require 'spec_helper'

describe MoviesController do
  describe 'show' do
    it 'should instantiate @movie to the movie found by the find model class method with the id from the params' do
      fake_movie = mock('Movie99')
      Movie.stub(:find).and_return(fake_movie)
      get 'show', {:id => '99'}
      assigns(:movie).should == fake_movie
    end
  end

  describe 'index' do
    it 'should instantiate @title_header to "hilite" when user selects sorting by title' do
      get 'index', {:sort => 'title'}
      assigns(:title_header).should == 'hilite' && assigns(:date_header).should_not == 'hilite'
    end
    it 'should instantiate @date_header to "hilite" when user selects sorting by release_date' do
      get 'index', {:sort => 'release_date'}
      assigns(:date_header).should == 'hilite' && assigns(:title_header).should_not == 'hilite'
    end
    it 'should instantiate @all_ratings with the result of calling the all_ratings model class method' do
      all_ratings = [ 'rating1','rating2', 'rating3']
      Movie.stub(:all_ratings).and_return(all_ratings)
      get 'index'
      assigns(:all_ratings).should == all_ratings
    end
  end

  describe 'new' do
    it 'should render new template' do
      get 'new'
      response.should render_template('new')
    end
  end

  describe 'create' do
    it 'should call the movie model class method create with the movie hash in from the params' do
      fake_movie = mock('Movie99', :title => 'title1')
      Movie.stub(:create!).and_return(fake_movie)
      get 'create', :movie => {:title => 'title1'}
      assigns(:movie).should == fake_movie
    end
  end

  describe 'edit' do
    it 'should instantiate @movie to the movie found by the find model class method with the id from the params' do
      fake_movie = mock('Movie99')
      Movie.stub(:find).and_return(fake_movie)
      get 'edit', {:id => '99'}
      assigns(:movie).should == fake_movie
    end
  end

  describe 'update' do
    it 'should instantiate @movie to the movie found by the find model class method with the id from the params' do
      fake_movie = mock('Movie99', :title => 'The Movie 99', :update_attributes! => nil)
      Movie.stub(:find).and_return(fake_movie)
      post 'update', {:id => '99', :movie => {:title => 'new_title'}}
      assigns(:movie).should == fake_movie
    end
  end

  describe 'destroy' do
    it 'should instantiate @movie to the movie found by the find model class method with the id from the params' do
      fake_movie = mock('Movie99', :title => 'The Movie 99', :destroy => nil)
      Movie.stub(:find).and_return(fake_movie)
      get 'destroy', {:id => '99'}
      assigns(:movie).should == fake_movie
    end
  end

  describe 'finding similar movies' do
    it 'should instantiate @movie with the movie with the id from the params' do
      fake_movie = mock('Movie99', :find_similar_movies => [], :director => 'director1')
      Movie.stub(:find).and_return(fake_movie)
      get 'find_similar_movies', {:id => 99}
      assigns(:movie).should == fake_movie
    end
    it 'should call the model instance method that finds movies with same director and instantiate @similar_movies with the result' do
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
