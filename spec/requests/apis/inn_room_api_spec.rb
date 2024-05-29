require 'rails_helper'

describe 'Inn Room API' do
  context 'GET /api/v1/inn_rooms' do
    it 'successfully' do
      inn_owner = InnOwner
        .create! first_name: 'Joao',
                 last_name: 'Almeida',
                 document: '53783222001',
                 email: 'joao@email.com',
                 password: '123456'

      inn = inn_owner
        .create_inn! name: 'Pousada do Almeidinha',
                     registration_number: '30638898000199',
                     description: 'Um bom lugar',
                     address_attributes: {
                       address: 'Rua X',
                       number: '100',
                       city: 'Manaus',
                       state: 'AM',
                       postal_code: '69067-080',
                       neighborhood: 'Centro' }

      inn_room = inn.inn_rooms
        .create! name: 'Quarto com Varanda',
                 size: 35,
                 guest_limit: 3,
                 daily_rate_cents: 200_00

      get "/api/v1/inn_rooms/#{inn_room.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'

      json = JSON.parse response.body

      puts json

      expect(json[:name]).to eq 'Pousada do Almeidinha'
      expect(json[:size]).to eq 35
      expect(json[:guest_limit]).to eq 3
      expect(json[:daily_rate_cents]).to eq 200_00
      expect(json.keys).not_to include 'created_at'
      expect(json.keys).not_to include 'updated_at'
    end
  end
end