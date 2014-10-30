# require 'pry'
require 'bundler'
Bundler.require
require 'idea_box'


class IdeaBoxApp < Sinatra::Base
  register Sinatra::Reloader
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
    binding.pry
  end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {idea: idea}
  end

  get '/search' do
    idea_search = IdeaStore.search(params[:phrase])
    erb :search, locals: { idea_search: idea_search }
  end

  get '/:tag/search' do
    idea_search = IdeaStore.search(params[:tag])
    erb :search, locals: {idea_search: idea_search}
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  not_found do
    erb :error
  end
end