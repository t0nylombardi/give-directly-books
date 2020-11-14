require 'rails_helper'

describe "request rooute", :type => :request do
   
  let!(:books) {FactoryBot.create_list(:book, 20)}
  
  
  context " get /request" do 
    before {get '/api/v1/request'}
    
    it 'returns all questions' do
        expect(JSON.parse(response.body).size).to eq(20)
    end
  end

  context "get request/:id" do 
    before {get "/api/v1/request/#{books[3].id}"}
    
    it 'returns book based on id' do
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(%w(id available title timestamp created_at updated_at))
    end
  end
  
  context "get request/:id with invailed id" do 
    
    it 'returns all books' do
      get "/api/v1/request/99999999"
      
      expect(JSON.parse(response.body).size).to eq(20)
      expect(response).to have_http_status(200)
    end
  end

  context "delete /request/id" do 
    
    before do 
      params = {
        email: 'userTester@gmail.com',
        title: books[3].title  
      }
      post "/api/v1/request/", params: params.to_json
    end

    it 'returns found book by title' do
      
      delete "/api/v1/request/#{books[3].id}"
      expect(response).to have_http_status(200)
      expect(response.body).to match(/Your request for book #{books[3].title} has been removed/)
    end
  end
  
  context "post /request" do 
    
    it 'returns found book by title' do
      params = {
        email: 'userTester@gmail.com',
        title: books[1].title  
      }
      post "/api/v1/request/", params: params.to_json
      expect(response.body).to match(/invailed email/)
      expect(response).to have_http_status(400)
    end
  end
  
end
