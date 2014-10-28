require 'bundler'
Bundler.require
require 'idea_box'

class IdeaBoxApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  set :method_override, true
  # set :views, 'lib/app/views'
  set :root, 'lib/app'
  raise root.inspect

  get '/' do
    erb :index, locals: {ideas: IdeaStore.all, idea: Idea.new(params)}
  end

  post '/' do
    IdeaStore.create(params[:idea])
    redirect '/'
  end

  delete '/:id' do |id|
    IdeaStore.delete(id.to_i)
    redirect '/'
  end

  get '/:id/edit' do |id|
    idea = IdeaStore.find(id.to_i)
    erb :edit, locals: {id: id, idea: idea}
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  not_found do
    erb :error
  end
end