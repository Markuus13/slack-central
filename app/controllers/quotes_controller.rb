class QuotesController < ApplicationController
  def index
  end

  def create
    head :ok if params[:token] == 'D72oye7v7EFlS1PMpk25Ej0G'
  end
end
