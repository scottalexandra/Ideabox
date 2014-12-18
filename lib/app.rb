require 'idea_box'

class IdeaBoxApp < Sinatra::Base
  set :method_override, true
  set :root, 'lib/app'

  not_found do
    erb :error
  end

  get '/' do
    erb :index, locals: {ideas: IdeaStore.all.sort, idea: Idea.new(params)}
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
    erb :edit, locals: {idea: idea}
  end

  put '/:id' do |id|
    IdeaStore.update(id.to_i, params[:idea])
    redirect '/'
  end

  post '/:id/like' do |id|
    idea = IdeaStore.find(id.to_i)
    idea.like!
    IdeaStore.update(id.to_i, idea.to_h)
    redirect '/'
  end

  # helpers do
  #   def shout(words)
  #     words.upcase
  #   end
  # end

  # register Sinatra::Partial
  # set :partial_template_engine, :erb

  # get '/playground' do
  #
  #   @thing = [
  #       {weather:"sunny", forecast:"cloudy"}
  #   ]
  #
  #   @adjective = ["nice", "wonderful", "sad"].shuffle.first
  #   erb :playground
  # end
  #
  # get '/no-layout' do
  #   erb :index, locals: {ideas: IdeaStore.all.sort, idea: Idea.new(params)}, layout: false
  # end
end
