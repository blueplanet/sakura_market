require 'spec_helper'

describe JournalsController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/journals').to route_to('journals#index')
    end

    it 'routes to #new' do
      expect(get: '/journals/new').to route_to('journals#new')
    end

    it 'routes to #show' do
      expect(get: '/journals/1').to route_to('journals#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/journals/1/edit').to route_to('journals#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/journals').to route_to('journals#create')
    end

    it 'routes to #update' do
      expect(put: '/journals/1').to route_to('journals#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/journals/1').to route_to('journals#destroy', id: '1')
    end

  end
end
