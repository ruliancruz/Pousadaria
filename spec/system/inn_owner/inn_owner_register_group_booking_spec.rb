require 'rails_helper'

describe 'Inn Owner register booking for group' do
  it 'from the inn management page' do
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

    login_as inn_owner, scope: inn_owner
    visit inn_management_path

    expect(page).to have_link 'Fazer Reserva Para Grupo'
  end
end