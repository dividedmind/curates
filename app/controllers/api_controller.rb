class ApiController < ApplicationController
  def rates
    keys = [:from, :to]
    keys.each { |k| params[k].upcase! }
    render json: Rate.where(params.slice(*keys).symbolize_keys).all
  end
end
