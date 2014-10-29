require 'bundler'
Bundler.require
require 'idea_box'


class IdeaBoxApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  set :method_override, true
  set :root, 'lib/app'

  get '/' do
    erb :index, locals: {ideas: IdeaStore.all.sort, idea: Idea.new(params)}
  end

  post '/' do
    IdeaStore.create(params[:idea])
    redirect '/'
  end

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end

  get '/*/search' do |text|
    'hello'
    idea = IdeaStore.find_words(text)
    erb :search, locals: {idea: idea}
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  not_found do
    erb :error
  end
end