require 'httparty'

class AdminController < ApplicationController
    def index
        # Obter os dados da API
        response = HTTParty.get('https://dispenser-smart-api-9ae096adb72b.herokuapp.com/esp8266s')
        data = JSON.parse(response.body)

        # Obter a quantidade total de IDs

        # Preparar os dados para o gráfico
        total_ids = data.count
        chart_data = data.map { |entry| [entry['created_at'], entry['cont']] }
        @total_ids = total_ids
        @chart_data_json = chart_data.to_json

        @users = User.where(role: 'user')
        @users_total = @users.count

        dose_price = DosePrice.first.price
        total_doses = data.sum { |entry| entry['cont'] }

        @total_price = total_doses * dose_price
        @results = data
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to admin_index_path, notice: "Usuário excluído com sucesso!"
    end
end