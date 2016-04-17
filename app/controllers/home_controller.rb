class HomeController < ApplicationController
  def index
    service = GoogleService.new
    @addresses = service.addresses
  end
end